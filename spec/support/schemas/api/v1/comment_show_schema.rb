# frozen_string_literal: true

module Api::V1
  module CommentSchema
    Show = Dry::Validation.Schema do
      required(:data).schema do
        required(:attributes).schema do
          required(:text).filled(:str?)
          required(:images).maybe(:array?)
        end
        required(:type).filled(:str?)
      end
    end
  end
end
