# frozen_string_literal: true

module Api::V1
  module User::Project::Task::Operation
    class Index < Api::V1::ApplicationOperation
      step Macro::Set(key: :model, value: lambda { |ctx|
                                            ctx[:current_user].projects.find_by(id: ctx[:params][:project_id]).tasks
                                          })
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
