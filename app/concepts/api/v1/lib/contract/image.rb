# frozen_string_literal: true

module Api::V1
  module Lib::Contract
    class Image < Api::V1::ApplicationContract
      property :image

      validation do
        configure do
          config.messages_file = 'config/locales/errors.yml'

          option :form

          def valid_img?(image)
            attacher = ImageUploader::Attacher.new
            attacher.assign(File.open(image))
            attacher.errors.empty?
          end
        end

        required(:image).filled(:valid_img?)
      end
    end
  end
end
