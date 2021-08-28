# frozen_string_literal: true

module Api::V1
  module User::Project::Task::Operation
    class Complete < Api::V1::ApplicationOperation
      step Macro::FindBy(path: %i[current_user tasks], param_path: %i[params task_id])
      fail Macro::Semantic(failure: :not_found)
      step :complete
      step Macro::Semantic(success: :created)
      step Macro::Serialize(serializer: Api::V1::TaskSerializer)

      def complete(_ctx, model:, **)
        model.update(completed: true)
      end
    end
  end
end
