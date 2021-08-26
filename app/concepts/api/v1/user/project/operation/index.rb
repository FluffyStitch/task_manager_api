# frozen_string_literal: true

module Api::V1
  module User::Project::Operation
    class Index < Api::V1::ApplicationOperation
      step Macro::Set(key: :model, value: ->(ctx) { ctx[:current_user].projects })
      step Subprocess(Api::V1::Lib::Operation::Pagination)
      step Macro::Serialize(serializer: Api::V1::ProjectSerializer)
    end
  end
end
