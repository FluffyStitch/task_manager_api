# frozen_string_literal: true

module Api::V1
  module User::Project::Operation
    class Show < Api::V1::ApplicationOperation
      step Macro::Set(key: :model, value: ->(ctx) { ctx[:current_user].projects.find_by(id: ctx[:params][:id]) })
      fail Macro::Set(key: :status, value: :not_found)
      step Macro::Serialize(serializer: Api::V1::ProjectSerializer)
    end
  end
end
