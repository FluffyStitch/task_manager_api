# frozen_string_literal: true

module Api::V1
  module Lib::Operation
    class GenerateTokens < Api::V1::ApplicationOperation
      step :session_data

      def session_data(ctx, model:, **)
        payload = { id: model.id }
        ctx[:session_data] = JWTSessions::Session.new(payload: payload, refresh_payload: payload).login
      end
    end
  end
end
