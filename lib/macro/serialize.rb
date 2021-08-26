# frozen_string_literal: true

module Macro
  def self.Serialize(serializer: Api::V1::ApplicationSerializer, meta: nil)
    task = Trailblazer::Activity::TaskBuilder::Binary(Macro::Serialize.new(serializer: serializer, meta: meta))
    { task: task, id: "serialize.#{SecureRandom.hex}" }
  end

  class Serialize
    def initialize(serializer:, meta:)
      @serializer = serializer
      @meta = meta
    end

    def call(ctx, **)
      ctx[:serializer_data] = { serializer: @serializer, meta: ctx[@meta] }
    end
  end
end
