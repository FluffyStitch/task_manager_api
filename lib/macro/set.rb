# frozen_string_literal: true

module Macro
  def self.Set(key:, value:)
    task = Trailblazer::Activity::TaskBuilder::Binary(Macro::Set.new(key: key, value: value))
    { task: task, id: "set.#{SecureRandom.hex}" }
  end

  class Set
    def initialize(key:, value:)
      @key = key
      @value = value
    end

    def call(ctx, **)
      ctx[@key] = @value.is_a?(Proc) ? @value[ctx] : @value
    end
  end
end
