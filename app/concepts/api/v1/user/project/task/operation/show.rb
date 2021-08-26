# frozen_string_literal: true

module Api::V1
  module User::Project::Task::Operation
    class Show < Api::V1::ApplicationOperation
      step Macro::Set(key: :model, value: ->(ctx) { ctx[:current_user].tasks.find_by(id: ctx[:params][:id]) })
      fail Macro::Set(key: :status, value: :not_found)
      step Macro::Serialize(serializer: Api::V1::TaskSerializer)
    end
  end
end
