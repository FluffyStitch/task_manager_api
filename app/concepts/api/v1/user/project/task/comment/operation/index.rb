# frozen_string_literal: true

module Api::V1
  module User::Project::Task::Comment::Operation
    class Index < Api::V1::ApplicationOperation
      step Macro::Set(key: :model, value: lambda { |ctx|
                                            ctx[:current_user].tasks.find_by(id: ctx[:params][:task_id]).comments
                                          })
      step Macro::Serialize(serializer: Api::V1::CommentSerializer)
    end
  end
end
