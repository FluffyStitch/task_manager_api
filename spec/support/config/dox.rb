# frozen_string_literal: true

Dox.configure do |config|
  config.headers_whitelist = %w[Authorization X-Refresh-Token] # rubocop:disable Naming/InclusiveLanguage
  config.title = 'API'
  config.api_version = '1.0'
end
