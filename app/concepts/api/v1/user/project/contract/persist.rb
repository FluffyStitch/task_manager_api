# frozen_string_literal: true

module Api::V1
  module User::Project::Contract
    class Persist < Api::V1::ApplicationContract
      property :name

      validation do
        configure do
          option :form

          def unique?(name)
            !form.model.user.projects.exists?(name: name)
          end
        end

        required(:name).filled(:str?, :unique?)
      end
    end
  end
end
