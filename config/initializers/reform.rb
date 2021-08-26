require 'reform'
require 'reform/form/dry'


Dry::Validation::Schema.configure do |config|
  config.messages = :i18n
  config.input_processor = :sanitizer
end

Dry::Validation::Schema::Form.configure do |config|
  config.messages = :i18n
end
