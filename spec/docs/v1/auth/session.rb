# frozen_string_literal: true

module Docs
  module V1
    module Auth
      module Session
        extend Dox::DSL::Syntax

        document :api do
          resource 'Session' do
            group 'API'
          end
        end

        document :create do
          action 'Sign in user' do
            verb 'POST'
            desc 'Sign in user by email and password'
            params(
              email: {
                required: true,
                type: 'string',
                value: 'email@email.com',
                description: 'User email'
              },
              password: {
                required: true,
                type: 'string',
                value: 'password123',
                description: 'User password'
              }
            )
          end
        end

        document :destroy do
          action 'Log out user' do
            verb 'DELETE'
            desc 'Log out user'
          end
        end
      end
    end
  end
end
