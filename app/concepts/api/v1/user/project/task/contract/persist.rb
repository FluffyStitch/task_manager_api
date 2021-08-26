# frozen_string_literal: true

module Api::V1
  module User::Project::Task::Contract
    class Persist < Api::V1::ApplicationContract
      property :text
      property :deadline

      validation do
        configure do
          config.messages_file = 'config/locales/errors.yml'

          option :form

          def in_future?(deadline)
            Time.zone.parse(deadline).present?
          end
        end

        required(:text).filled(:str?)
        required(:deadline) { empty? | in_future? }
      end
    end
  end
end
