# frozen_string_literal: true

module Docs
  module V1
    module Task
      extend Dox::DSL::Syntax

      document :api do
        resource 'Task' do
          group 'API'
        end
      end

      document :index do
        action 'Show a list of tasks' do
          verb 'GET'
          desc 'A list of Tasks'
          params(
            project_id: {
              required: true,
              type: 'int',
              value: '1',
              description: "Project's id"
            }
          )
        end
      end

      document :create do
        action 'Create task' do
          verb 'POST'
          desc 'Creates a Task'
          params(
            project_id: {
              required: true,
              type: 'int',
              value: '1',
              description: "Project's id"
            },
            text: {
              required: true,
              type: 'string',
              value: 'Do homework',
              description: 'Text of task'
            },
            deadline: {
              required: false,
              type: 'date',
              value: '11.11.2021',
              description: 'Deadline of task'
            }
          )
        end
      end

      document :show do
        action 'Show a task' do
          verb 'GET'
          desc 'Shows the Task'
          params(
            id: {
              required: true,
              type: 'int',
              value: '1',
              description: "Task's id"
            }
          )
        end
      end

      document :update do
        action 'Update a task' do
          verb 'PATCH'
          desc 'Updates the Task'
          params(
            id: {
              required: true,
              type: 'int',
              value: '1',
              description: "Task's id"
            },
            text: {
              required: true,
              type: 'string',
              value: 'Do homework',
              description: 'Text of task'
            },
            deadline: {
              required: false,
              type: 'date',
              value: '11.11.2021',
              description: 'Deadline of task'
            }
          )
        end
      end

      document :destroy do
        action 'Delete a task' do
          verb 'DELETE'
          desc 'Deletes the Task'
          params(
            id: {
              required: true,
              type: 'int',
              value: '1',
              description: "Task's id"
            }
          )
        end
      end

      document :complete do
        action 'Complete a task' do
          verb 'PATCH'
          desc 'Mark task as complete'
          params(
            id: {
              required: true,
              type: 'int',
              value: '1',
              description: "Task's id"
            }
          )
        end
      end

      document :position do
        action 'Proritizate task' do
          verb 'PATCH'
          desc 'Move position of task'
          params(
            id: {
              required: true,
              type: 'int',
              value: '1',
              description: "Task's id"
            },
            position: {
              required: true,
              type: 'string',
              value: 'up',
              description: 'Move task higher or lower'
            }
          )
        end
      end
    end
  end
end
