# frozen_string_literal: true

module Api::V1
  ErrorSchema = Dry::Validation.Schema do
    required(:errors).filled(:hash?)
  end
end
