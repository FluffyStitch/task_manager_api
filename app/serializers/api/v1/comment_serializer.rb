# frozen_string_literal: true

module Api::V1
  class CommentSerializer < Api::V1::ApplicationSerializer
    attribute :text
    attribute :images
  end
end
