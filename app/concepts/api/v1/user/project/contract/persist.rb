# frozen_string_literal: true

module Api::V1
  module User::Project::Contract
    class Persist < Api::V1::ApplicationContract
      property :name

      validation do
        configure do
          config.messages_file = 'config/locales/errors.yml'

          option :form

          def unique?(name)
            form.model.user.projects.where.not(id: form.model.id).where(name: name).empty?
          end
        end

        required(:name).filled(:unique?)
      end
    end
  end
end
