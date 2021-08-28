# frozen_string_literal: true

module Api::V1
  module User::Project::Task::Comment::Contract
    class Create < Api::V1::ApplicationContract
      LENGTH = (10..256).freeze

      property :text
      collection :images, form: Api::V1::Lib::Contract::Image, populate_if_empty: ::Image

      validation do
        required(:text).filled(:str?, size?: LENGTH)
        required(:images).maybe(:array?)
      end
    end
  end
end
