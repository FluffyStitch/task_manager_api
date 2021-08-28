# frozen_string_literal: true

module Api::V1
  module UserSchema
    Show = Dry::Validation.Schema do
      required(:data).schema do
        required(:id).filled(:str?)
        required(:type).filled(:str?)
        required(:attributes).schema do
          required(:email).filled(:str?)
        end
      end
      required(:meta).schema do
        required(:csrf).filled(:str?)
        required(:access).filled(:str?)
        required(:access_expires_at).filled(:str?)
        required(:refresh).filled(:str?)
        required(:refresh_expires_at).filled(:str?)
      end
    end
  end
end
