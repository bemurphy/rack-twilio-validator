require File.expand_path("../../lib/rack/twilio-validator", __FILE__)
require "rack/test"

RSpec.configure do |config|
  config.mock_with :rspec
  config.include Rack::Test::Methods
end

