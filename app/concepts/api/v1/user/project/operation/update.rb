# frozen_string_literal: true

module Api::V1
  module User::Project::Operation
    class Update < Api::V1::ApplicationOperation
      step Macro::FindBy(path: %i[current_user projects])
      fail Macro::Semantic(failure: :not_found)
      step Contract::Build(constant: Api::V1::User::Project::Contract::Persist)
      step Contract::Validate()
      step Contract::Persist()
      step Macro::Semantic(success: :created)
      step Macro::Serialize(serializer: Api::V1::ProjectSerializer)
    end
  end
end
