# frozen_string_literal: true

module Macro
  def self.FindBy(path: %i[], attribute: :id, param_path: %i[params id], model: :model)
    task = lambda { |ctx, **|
      ctx[model] = path.drop(1).inject(ctx[path.first], :public_send).find_by(attribute => param_path.inject(ctx, :[]))
    }

    task = Trailblazer::Activity::TaskBuilder::Binary(task)
    { task: task, id: "find_by.#{SecureRandom.hex}" }
  end
end
