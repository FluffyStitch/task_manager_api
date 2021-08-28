# frozen_string_literal: true

module Macro
  def self.Semantic(success: nil, failure: nil)
    task = Trailblazer::Activity::TaskBuilder::Binary(
      lambda { |ctx, **|
        ctx[:semantic_success] = success
        ctx[:semantic_failure] = failure
        true
      }
    )
    { task: task, id: "semantic.#{SecureRandom.hex}" }
  end
end
