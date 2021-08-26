# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JWTSessions::RailsAuthorization
  include SimpleEndpoint::Controller

  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  private

  def not_authorized
    render status: :unauthorized
  end

  def default_cases # rubocop:disable Metrics/AbcSize
    {
      failure: ->(result) { result['contract.default'] && !result['contract.default'].errors.empty? },
      unauthorized: ->(result) { result[:status] == :unauthorized },
      not_found: ->(result) { result[:status] == :not_found },
      created: ->(result) { result[:status] == :created },
      no_content: ->(result) { result[:status] == :no_content },
      success: ->(result) { result.success? },
      bad_request: ->(result) { result.failure? && result['contract.uri_query']&.errors.present? }
    }
  end

  def default_handler # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    {
      success: ->(result, **) { success_response(result) },
      created: ->(result, **) { success_response(result, :created) },
      failure: lambda { |result, **|
        render json: { errors: result['contract.default'].errors.messages }, status: :unprocessable_entity
      },
      unauthorized: ->(_, **) { render status: :unauthorized },
      not_found: ->(_, **) { render status: :not_found },
      no_content: ->(_, **) { render status: :no_content },
      bad_request: lambda { |result, **|
        render json: { errors: result['contract.uri_query'].errors.messages }, status: :bad_request
      }
    }
  end

  def endpoint_options
    { params: params.permit!.to_h }
  end

  def success_response(result, status = :ok)
    render json: ResourceSerializer.call(result), status: status
  end
end
