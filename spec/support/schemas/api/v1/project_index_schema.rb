# frozen_string_literal: true

module Api::V1
  module ProjectSchema
    Index = Dry::Validation.Schema do
      required(:data).filled(:array?).each do
        required(:id).filled(:str?)
        required(:type).filled(:str?)
        required(:attributes).schema do
          required(:name).filled(:str?)
        end
        required(:relationships).schema do
          required(:tasks).schema do
            required(:data).maybe(:array?).each do
              required(:id).filled(:str?)
              required(:type).filled(:str?)
            end
          end
          required(:user).schema do
            required(:data).schema do
              required(:id).filled(:str?)
              required(:type).filled(:str?)
            end
          end
        end
        required(:links).schema do
          required(:self).filled(:str?)
        end
      end
    end
  end
end
