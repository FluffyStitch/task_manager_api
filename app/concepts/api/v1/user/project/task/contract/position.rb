# frozen_string_literal: true

module Api::V1
  module User::Project::Task::Contract
    class Position < Api::V1::ApplicationContract
      POSITION = %w[up down].freeze

      property :position

      validation do
        required(:position).filled(included_in?: POSITION)
      end
    end
  end
end
