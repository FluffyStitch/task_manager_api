# frozen_string_literal: true

module Api::V1
  module User::Project::Task::Operation
    class Complete < Api::V1::ApplicationOperation
      step Macro::Set(key: :model, value: ->(ctx) { ctx[:current_user].tasks.find_by(id: ctx[:params][:task_id]) })
      fail Macro::Set(key: :status, value: :not_found)
      step :complete
      step Macro::Set(key: :status, value: :created)
      step Macro::Serialize(serializer: Api::V1::TaskSerializer)

      def complete(_ctx, model:, **)
        model.update(completed: !model.completed)
      end
    end
  end
end
