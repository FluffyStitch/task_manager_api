# frozen_string_literal: true

class ImageUploader < Shrine
  Attacher.validate do
    validate_size 1..(10.megabytes)
    validate_mime_type %w[image/jpeg image/png]
    validate_extension %w[jpg png]
  end
end
