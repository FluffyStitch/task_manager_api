Dir[Rails.root.join('lib/**/*.rb')].sort.each { |file| require file }
