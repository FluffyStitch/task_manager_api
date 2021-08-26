# frozen_string_literal: true

module Api::V1
  SuccessSchema = Dry::Validation.Schema do
    required(:success).filled(:bool?)
  end
end
