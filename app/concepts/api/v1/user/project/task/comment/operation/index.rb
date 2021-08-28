# frozen_string_literal: true

module Api::V1
  module User::Project::Task::Comment::Operation
    class Index < Api::V1::ApplicationOperation
      step Macro::FindBy(path: %i[current_user tasks], param_path: %i[params task_id], model: :task)
      fail Macro::Semantic(failure: :not_found)
      step Macro::Assign(to: :model, path: %i[task comments])
      step Macro::Serialize(serializer: Api::V1::CommentSerializer)
    end
  end
end
