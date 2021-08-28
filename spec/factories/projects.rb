# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { FFaker::AnimalUS.common_name }
    user { create(:user) }
    tasks { [] }
  end
end
