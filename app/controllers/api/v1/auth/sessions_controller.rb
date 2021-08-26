# frozen_string_literal: true

module Api::V1
  module Auth
    class SessionsController < ApplicationController
      before_action :authorize_refresh_request!, only: %i[destroy]

      def create
        endpoint operation: Api::V1::User::Session::Operation::Create
      end

      def destroy
        endpoint operation: Api::V1::User::Session::Operation::Destroy,
                 options: { refresh_token: request_headers[JWTSessions.refresh_header] }
      end
    end
  end
end
