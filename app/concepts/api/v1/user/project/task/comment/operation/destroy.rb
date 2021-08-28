# frozen_string_literal: true

module Api::V1
  module User::Project::Task::Comment::Operation
    class Destroy < Api::V1::ApplicationOperation
      step Macro::FindBy(path: %i[current_user comments])
      fail Macro::Semantic(failure: :not_found)
      step :destroy
      step Macro::Semantic(success: :no_content)

      def destroy(_ctx, model:, **)
        model.destroy
      end
    end
  end
end
