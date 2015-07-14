ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
include Warden::Test::Helpers

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...

  def login_for_performance_test

    user = User.last
    login_as(user, :scope => :user)

  end

  def help_setup
    Warden.test_mode!
  end

  def help_tear_down
    Warden.test_reset!
  end

end
