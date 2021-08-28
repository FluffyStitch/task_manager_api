# frozen_string_literal: true

module Api::V1
  module User::Project::Task::Operation
    class Create < Api::V1::ApplicationOperation
      step Macro::FindBy(path: %i[current_user projects], param_path: %i[params project_id], model: :project)
      fail Macro::Semantic(failure: :not_found)
      step Macro::Assign(to: :model, path: %i[project tasks new])
      step Contract::Build(constant: Api::V1::User::Project::Task::Contract::Persist)
      step Contract::Validate()
      step Contract::Persist()
      step Macro::Semantic(success: :created)
      step Macro::Serialize(serializer: Api::V1::TaskSerializer)
    end
  end
end
