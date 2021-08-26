# frozen_string_literal: true

module Api::V1
  class TaskSerializer < Api::V1::ApplicationSerializer
    attribute :commentsCount do |task|
      task.comments.count
    end
    attribute :text
    attribute :completed
    attribute :deadline
    attribute :position

    has_many :comments
  end
end
