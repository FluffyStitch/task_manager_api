# frozen_string_literal: true

FactoryBot.define do
  factory :image do
    image { Rack::Test::UploadedFile.new('spec/fixtures/images/unicorn.png', 'image/jpeg') }
    comment { create(:comment) }
  end
end
