# frozen_string_literal: true

module Api::V1
  class ProjectSerializer < Api::V1::ApplicationSerializer
    attribute :name

    has_many :tasks
    belongs_to :user

    link :self, :url do |project|
      url_helpers.api_v1_project_url(project)
    end
  end
end
