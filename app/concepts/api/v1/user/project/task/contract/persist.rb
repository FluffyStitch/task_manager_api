# frozen_string_literal: true

module Api::V1
  module User::Project::Task::Contract
    class Persist < Api::V1::ApplicationContract
      property :text
      property :deadline

      validation do
        configure do
          option :form

          def in_future?(deadline)
            deadline >= Time.zone.today
          end
        end

        required(:text).filled(:str?)
        required(:deadline).maybe(:date?, :in_future?)
      end
    end
  end
end
