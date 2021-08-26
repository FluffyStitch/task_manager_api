# frozen_string_literal: true

class Container
  extend Dry::Container::Mixin

  namespace 'services' do
    register('pagy') { Service::Pagy }
  end
end
