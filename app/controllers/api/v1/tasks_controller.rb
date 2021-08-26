# frozen_string_literal: true

module Api::V1
  class TasksController < AuthorizedController
    def index
      endpoint operation: Api::V1::User::Project::Task::Operation::Index
    end

    def create
      endpoint operation: Api::V1::User::Project::Task::Operation::Create
    end

    def show
      endpoint operation: Api::V1::User::Project::Task::Operation::Show
    end

    def update
      endpoint operation: Api::V1::User::Project::Task::Operation::Update
    end

    def destroy
      endpoint operation: Api::V1::User::Project::Task::Operation::Destroy
    end

    def complete
      endpoint operation: Api::V1::User::Project::Task::Operation::Complete
    end

    def position
      endpoint operation: Api::V1::User::Project::Task::Operation::Position
    end
  end
end
