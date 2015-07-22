ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  setup do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google] = nil

    File.open('test/fixtures/login_oauth_google_response.json', 'r') do |f|
      @omniauth_response_hash = JSON.parse(f.read)
    end
    OmniAuth.config.add_mock(:google, @omniauth_response_hash)
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
  end

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
