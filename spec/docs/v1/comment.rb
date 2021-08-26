# frozen_string_literal: true

module Docs
  module V1
    module Comment
      extend Dox::DSL::Syntax

      document :api do
        resource 'Project' do
          group 'API'
        end
      end

      document :index do
        action 'Show a list of comments' do
          verb 'GET'
          desc 'A list of Comments'
          params(
            task_id: {
              required: true,
              type: 'int',
              value: '1',
              description: "Task's id"
            }
          )
        end
      end

      document :create do
        action 'Create comment' do
          verb 'POST'
          desc 'Creates a Comment'
          params(
            task_id: {
              required: true,
              type: 'int',
              value: '1',
              description: "Task's id"
            },
            text: {
              required: true,
              type: 'string',
              value: 'Math and Physics',
              description: 'Text of comment'
            },
            images: {
              required: false,
              type: 'array',
              value: 'files',
              description: 'Image attachment'
            }
          )
        end
      end

      document :destroy do
        action 'Delete a comment' do
          verb 'DELETE'
          desc 'Deletes the Comment'
          params(
            id: {
              required: true,
              type: 'int',
              value: '1',
              description: "Comment's id"
            }
          )
        end
      end
    end
  end
end
