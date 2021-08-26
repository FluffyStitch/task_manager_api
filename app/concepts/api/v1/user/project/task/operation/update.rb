# frozen_string_literal: true

module Api::V1
  module User::Project::Task::Operation
    class Update < Api::V1::ApplicationOperation
      step Macro::Set(key: :model, value: ->(ctx) { ctx[:current_user].tasks.find_by(id: ctx[:params][:id]) })
      fail Macro::Set(key: :status, value: :not_found)
      step Contract::Build(constant: Api::V1::User::Project::Task::Contract::Persist)
      step Contract::Validate()
      step Contract::Persist()
      step Macro::Set(key: :status, value: :created)
      step Macro::Serialize(serializer: Api::V1::TaskSerializer)
    end
  end
end
