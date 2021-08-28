# frozen_string_literal: true

module Api::V1
  module User::Project::Task::Operation
    class Position < Api::V1::ApplicationOperation
      step Macro::FindBy(path: %i[current_user tasks], param_path: %i[params task_id])
      fail Macro::Semantic(failure: :not_found)
      step Contract::Build(constant: Api::V1::User::Project::Task::Contract::Position)
      step Contract::Validate()
      step :reprioritate
      step Macro::Semantic(success: :created)
      step Macro::Serialize(serializer: Api::V1::TaskSerializer)

      def reprioritate(_ctx, model:, params:, **)
        params[:position] == 'up' ? model.move_higher : model.move_lower
      end
    end
  end
end
