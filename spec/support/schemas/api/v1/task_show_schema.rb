# frozen_string_literal: true

module Api::V1
  module TaskSchema
    Show = Dry::Validation.Schema do
      required(:data).schema do
        required(:attributes).schema do
          required(:commentsCount).filled(:int?)
          required(:completed).filled(:bool?)
          required(:deadline).maybe(:date?)
          required(:text).filled(:str?)
          required(:position).filled(:int?)
        end
        required(:relationships).schema do
          required(:comments).schema do
            required(:data).maybe(:array?).each do
              required(:id).filled(:str?)
              required(:type).filled(:str?)
            end
          end
        end
        required(:type).filled(:str?)
      end
    end
  end
end
