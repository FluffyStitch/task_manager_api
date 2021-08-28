# frozen_string_literal: true

module Api::V1
  module User::Project::Task::Operation
    class Index < Api::V1::ApplicationOperation
      step Macro::FindBy(path: %i[current_user projects], param_path: %i[params project_id], model: :project)
      fail Macro::Semantic(failure: :not_found)
      step Macro::Assign(to: :model, path: %i[project tasks])
      step Macro::Set(
        key: :available_columns,
        value: Api::V1::Lib::Service::JsonApi::ColumnsBuilder.call(
          { name: 'deadline', type: :date, filterable: true },
          { name: 'completed', type: :boolean, filterable: true }
        )
      )
      step Subprocess(Api::V1::Lib::Operation::Filtering)
      step Subprocess(Api::V1::Lib::Operation::PerformFiltering)
      step Macro::Serialize(serializer: Api::V1::TaskSerializer)
    end
  end
end
