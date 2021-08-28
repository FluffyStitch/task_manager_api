# frozen_string_literal: true

module Api::V1
  module TaskSchema
    Index = Dry::Validation.Schema do
      required(:data).filled(:array?).each do
        required(:attributes).schema do
          required(:commentsCount).filled(:int?)
          required(:completed).filled(:bool?)
          required(:deadline).maybe(:date?)
          required(:name).filled(:str?)
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
