# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors, with: :threads)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    def log_in_as(user, options = {})
      password = options[:password] || "password"
      if integration_test?
        post login_path, params: {
          email: user.email,
          password:
        }
      else
        session[:user_id] = user.id
      end
    end

    def is_logged_in?
      !session[:user_id].nil?
    end

    private

    def integration_test?
      defined? follow_redirect!
    end
  end
end
