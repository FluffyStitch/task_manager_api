# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { (Array.new(7) { ('a'..'z').to_a.sample } << ('0'..'9').to_a.sample).join.capitalize }
    password_confirmation { password }
  end
end
