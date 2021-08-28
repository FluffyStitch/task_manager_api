# frozen_string_literal: true

module Api::V1
  class ProjectsController < AuthorizedController
    def index
      endpoint operation: Api::V1::User::Project::Operation::Index
    end

    def create
      endpoint operation: Api::V1::User::Project::Operation::Create
    end

    def show
      endpoint operation: Api::V1::User::Project::Operation::Show
    end

    def update
      endpoint operation: Api::V1::User::Project::Operation::Update
    end

    def destroy
      endpoint operation: Api::V1::User::Project::Operation::Destroy
    end
  end
end
