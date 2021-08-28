# frozen_string_literal: true

module Docs
  module V1
    module Project
      extend Dox::DSL::Syntax

      document :api do
        resource 'Project' do
          group 'API'
        end
      end

      document :index do
        action 'Show a list of projects' do
          verb 'GET'
          desc 'A list of Projects'
        end
      end

      document :create do
        action 'Create project' do
          verb 'POST'
          desc 'Creates a Project'
          params(
            name: {
              required: true,
              type: 'string',
              value: 'Home',
              description: 'Project name'
            }
          )
        end
      end

      document :show do
        action 'Show a project' do
          verb 'GET'
          desc 'Shows the Project'
          params(
            id: {
              required: true,
              type: 'int',
              value: '1',
              description: "Project's id"
            }
          )
        end
      end

      document :update do
        action 'Update a project' do
          verb 'PATCH'
          desc 'Updates the Project'
          params(
            id: {
              required: true,
              type: 'int',
              value: '1',
              description: "Project's id"
            },
            name: {
              required: true,
              type: 'string',
              value: 'Home',
              description: 'Project name'
            }
          )
        end
      end

      document :destroy do
        action 'Delete a project' do
          verb 'DELETE'
          desc 'Deletes the Project'
          params(
            id: {
              required: true,
              type: 'int',
              value: '1',
              description: "Project's id"
            }
          )
        end
      end
    end
  end
end
