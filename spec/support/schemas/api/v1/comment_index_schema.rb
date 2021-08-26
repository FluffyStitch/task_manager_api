# frozen_string_literal: true

module Api::V1
  module CommentSchema
    Index = Dry::Validation.Schema do
      required(:data).filled(:array?).each do
        required(:attributes).schema do
          required(:text).filled(:str?)
          required(:images).maybe(:array?)
        end
        required(:type).filled(:str?)
      end
    end
  end
end
