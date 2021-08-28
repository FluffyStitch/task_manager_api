# frozen_string_literal: true

module Api::V1
  module User::Registration::Operation
    class Create < Api::V1::ApplicationOperation
      step Model(::User, :new)
      step Contract::Build(constant: Api::V1::User::Registration::Contract::Create)
      step Contract::Validate()
      step Contract::Persist()
      step Macro::Semantic(success: :created)
      step Subprocess(Api::V1::Lib::Operation::GenerateTokens)
      step Macro::Serialize(serializer: Api::V1::UserSerializer, meta: :session_data)
    end
  end
end
