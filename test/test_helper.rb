# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    def sign_in_as(user)
      post user_session_url params:{ user: {email: user.email, password: user.password}}
    end

    # Add more helper methods to be used by all tests here...
  end
end
