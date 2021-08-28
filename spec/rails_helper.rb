# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  minimum_coverage 95
end

require 'dox'

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

%w[spec/docs/**/*.rb spec/support/**/*.rb].each { |path| Dir[Rails.root.join(path)].sort.each { |f| require f } }
