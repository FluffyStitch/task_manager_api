# frozen_string_literal: true

module Api::V1
  module User::Project::Task::Operation
    class Position < Api::V1::ApplicationOperation
      step Macro::Set(key: :model, value: ->(ctx) { ctx[:current_user].tasks.find_by(id: ctx[:params][:task_id]) })
      fail Macro::Set(key: :status, value: :not_found)
      step Contract::Build(constant: Api::V1::User::Project::Task::Contract::Position)
      step Contract::Validate()
      step :reprioritate
      step Macro::Set(key: :status, value: :created)
      step Macro::Serialize(serializer: Api::V1::TaskSerializer)

      def reprioritate(_ctx, model:, params:, **)
        params[:position] == 'up' ? model.move_higher : model.move_lower
      end
    end
  end
end
