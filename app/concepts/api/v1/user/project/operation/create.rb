# frozen_string_literal: true

module Api::V1
  module User::Project::Operation
    class Create < Api::V1::ApplicationOperation
      step Macro::Set(key: :model, value: ->(ctx) { ctx[:current_user].projects.new })
      step Contract::Build(constant: Api::V1::User::Project::Contract::Persist)
      step Contract::Validate()
      step Contract::Persist()
      step Macro::Set(key: :status, value: :created)
      step Macro::Serialize(serializer: Api::V1::ProjectSerializer)
    end
  end
end
