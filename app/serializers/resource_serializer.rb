# frozen_string_literal: true

class ResourceSerializer
  def self.call(result)
    data = result[:serializer_data]
    return nil unless data

    serializer = data.delete(:serializer)
    serializer.new(result[:model], **data)
  end
end
