ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :minitest
      with.library :rails
    end
  end

  include FactoryBot::Syntax::Methods

  def json_response
    JSON.parse response.body
  end

  def auth_headers(email, password)
    post auth_login_url, params: { email: email, password: password }
    token = json_response["token"]
    { "Authorization": "Bearer #{token}" }
  end
end
