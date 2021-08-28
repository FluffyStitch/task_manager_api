# frozen_string_literal: true

module Api::V1
  module User::Registration::Contract
    class Create < Api::V1::ApplicationContract
      EMAIL_LENGTH = (3..50).freeze
      PASSWORD_LENGTH = 8
      PASSWORD_REGEX = /(?=.*[A-Za-z])(?=.*\d)/.freeze

      property :email
      property :password
      property :password_confirmation, virtual: true

      validation do
        configure do
          option :form

          def unique?(email)
            !form.model.class.exists?(email: email)
          end
        end

        required(:email).filled(:str?, :unique?, size?: EMAIL_LENGTH)
        required(:password).filled(:str?, min_size?: PASSWORD_LENGTH, format?: PASSWORD_REGEX).confirmation
      end
    end
  end
end
