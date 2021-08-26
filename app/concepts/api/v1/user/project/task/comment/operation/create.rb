# frozen_string_literal: true

module Api::V1
  module User::Project::Task::Comment::Operation
    class Create < Api::V1::ApplicationOperation
      step Macro::Set(key: :model, value: lambda { |ctx|
                                            ctx[:current_user].tasks.find_by(id: ctx[:params][:task_id]).comments.new
                                          })
      step Contract::Build(constant: Api::V1::User::Project::Task::Comment::Contract::Create)
      step Contract::Validate()
      step Contract::Persist()
      step Macro::Set(key: :status, value: :created)
      step Macro::Serialize(serializer: Api::V1::CommentSerializer)
    end
  end
end
