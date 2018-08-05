ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Method to "log in" a test user - params are the user object and its associated password string
  def sign_in_as(user, password)
    post login_path, params: { session: { email: user.email, password: password } }
  end
end
