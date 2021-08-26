# frozen_string_literal: true

module Api::V1
  module User::Project::Task::Operation
    class Destroy < Api::V1::ApplicationOperation
      step Macro::Set(key: :model, value: ->(ctx) { ctx[:current_user].tasks.find_by(id: ctx[:params][:id]) })
      fail Macro::Set(key: :status, value: :not_found)
      step :destroy
      step Macro::Set(key: :status, value: :no_content)

      def destroy(_ctx, model:, **)
        model.destroy
      end
    end
  end
end
