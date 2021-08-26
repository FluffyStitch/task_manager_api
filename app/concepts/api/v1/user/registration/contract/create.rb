# frozen_string_literal: true

module Api::V1
  module User::Registration::Contract
    class Create < Api::V1::ApplicationContract
      LENGTH = {
        email: (3..50),
        password: 8
      }.freeze
      PASSW_REGEX = /(?=.*[A-Za-z])(?=.*\d)/.freeze

      property :email
      property :password
      property :password_confirmation, virtual: true

      validation do
        required(:email).filled(size?: LENGTH[:email])
        required(:password).filled(min_size?: LENGTH[:password], format?: PASSW_REGEX).confirmation
      end
    end
  end
end
