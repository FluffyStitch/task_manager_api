# frozen_string_literal: true

module Api::V1
  module User::Session::Operation
    class Create < Api::V1::ApplicationOperation
      step Model(::User, :find_by, :email)
      step :authenticate
      fail Macro::Set(key: :status, value: :unauthorized)
      step Subprocess(Api::V1::Lib::Operation::GenerateTokens)
      step Macro::Serialize(serializer: Api::V1::UserSerializer, meta: :session_data)

      def authenticate(_ctx, model:, params:, **)
        model.authenticate(params[:password])
      end
    end
  end
end
