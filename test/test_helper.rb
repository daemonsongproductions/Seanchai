ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/autorun"
require "minitest/rails"
require 'minitest/rails/capybara'
require 'minitest/reporters'
require 'minitest/matchers'
require 'mongoid-minitest'
require "factory_girl"

Minitest::Reporters.use!

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"
DatabaseCleaner.strategy = :truncation

def mock_user_with_permit(permit_class, id = "id")
  user = mock("user")
  role = mock("role")
  role.stubs(:permissions_for).returns(permit_class.new(user))
  user.stubs(:id).returns(id)
  user.stubs(:role).returns(role)
  user.stubs(:permissions).returns(permit_class.new(user))
  user
end

def set_current_user(user)
  @controller.stubs(:current_user).returns(user)
end

def set_admin_user
  set_current_user(mock_user_with_permit(Permits::AdminPermit))
end

def set_member_user
  set_current_user(mock_user_with_permit(Permits::MemberPermit))
end

def set_guest_user
  set_current_user(mock_user_with_permit(Permits::GuestPermit))
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
end


class MiniTest::Spec
  include Mongoid::Matchers
  include Devise::TestHelpers
  include FactoryGirl::Syntax::Methods

  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end

  FactoryGirl.define do
    factory :user, aliases: [:creator, :editor] do
      username "saalon"
      password "password"
      email "email@email.com"
      initialize_with {User.find_or_initialize_by(username: username)}
    end
  end

  FactoryGirl.define do
    factory :story do
      ignore do
        creator
        title "Title Of My Story"
      end

      initialize_with { Story.new(title: title, creator: creator) }
    end
  end
end

require "mocha/setup"