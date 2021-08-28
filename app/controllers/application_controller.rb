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
      unauthorized: ->(result) { result[:semantic_failure] == :unauthorized },
      not_found: ->(result) { result[:semantic_failure] == :not_found },
      created: ->(result) { result[:semantic_success] == :created },
      no_content: ->(result) { result[:semantic_success] == :no_content },
      success: ->(result) { result.success? },
      bad_request: ->(result) { result.failure? && result['contract.uri_query']&.errors.present? }
    }
  end

  def default_handler
    {
      success: ->(result, **) { success_response(result) },
      created: ->(result, **) { success_response(result, :created) },
      failure: ->(result, **) { render_errors(result['contract.default'], :unprocessable_entity) },
      unauthorized: ->(_, **) { render_head(:unauthorized) },
      not_found: ->(_, **) { render_head(:not_found) },
      no_content: ->(_, **) { render_head(:no_content) },
      bad_request: ->(result, **) { render_errors(result['contract.uri_query'], :bad_request) }
    }
  end

  def endpoint_options
    { params: params.permit!.to_h }
  end

  def success_response(result, status = :ok)
    render json: ResourceSerializer.call(result), status: status
  end

  def render_errors(result, status)
    render json: { errors: result.errors.messages }, status: status
  end

  def render_head(status)
    render status: status
  end
end
