# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    text { FFaker::AnimalUS.common_name }
    project { create(:project) }
    position { project.tasks.count + 1 }
    completed { false }
    comments { [] }
  end
end
