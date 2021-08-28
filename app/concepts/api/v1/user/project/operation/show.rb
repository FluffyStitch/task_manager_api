# frozen_string_literal: true

module Api::V1
  module User::Project::Operation
    class Show < Api::V1::ApplicationOperation
      step Macro::FindBy(path: %i[current_user projects])
      fail Macro::Semantic(failure: :not_found)
      step Macro::Serialize(serializer: Api::V1::ProjectSerializer)
    end
  end
end
