# frozen_string_literal: true

module Api::V1
  module User::Session::Operation
    class Destroy < Api::V1::ApplicationOperation
      step :flush_session

      def flush_session(_ctx, refresh_token:, **)
        session = JWTSessions::Session.new
        session.flush_by_token(refresh_token)
      end
    end
  end
end
