# frozen_string_literal: true

module Api::V1
  module User::Project::Task::Operation
    class Show < Api::V1::ApplicationOperation
      step Macro::FindBy(path: %i[current_user tasks])
      fail Macro::Semantic(failure: :not_found)
      step Macro::Serialize(serializer: Api::V1::TaskSerializer)
    end
  end
end
