# frozen_string_literal: true

module Api::V1
  class CommentsController < AuthorizedController
    def index
      endpoint operation: Api::V1::User::Project::Task::Comment::Operation::Index
    end

    def create
      endpoint operation: Api::V1::User::Project::Task::Comment::Operation::Create
    end

    def destroy
      endpoint operation: Api::V1::User::Project::Task::Comment::Operation::Destroy
    end
  end
end
