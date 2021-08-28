# frozen_string_literal: true

module Docs
  module V1
    module Auth
      module Registration
        extend Dox::DSL::Syntax

        document :api do
          resource 'Registration' do
            group 'API'
          end
        end

        document :create do
          action 'Register user' do
            verb 'POST'
            desc 'Registrate user by email and password'
            params(
              email: {
                required: true,
                type: 'string',
                value: 'email@email.com',
                description: 'New user email'
              },
              password: {
                required: true,
                type: 'string',
                value: 'password123',
                description: 'New user password which contains min 1 number and 1 digit, length min 8 character'
              },
              password_confirmation: {
                required: true,
                type: 'string',
                value: 'password123',
                description: 'Password confirmation which match password'
              }
            )
          end
        end
      end
    end
  end
end
