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

def mock_user_with_role(role_class, id = "id")
  FactoryGirl.create(:user, id: id, role: role_class.new, email: "current@user.com", username: "currentuser")
end

def set_current_user(user)
  @controller.stubs(:current_user).returns(user)
end

def set_admin_user
  set_current_user(mock_user_with_role(Admin))
end

def set_member_user
  set_current_user(mock_user_with_role(Member))
end

def set_guest_user
  set_current_user(mock_user_with_role(Guest))
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
      creator
      title "Title Of My Story"
      initialize_with { Story.new(title: title, creator: creator) }
    end
  end

  FactoryGirl.define do
    factory :story_section do
      story
      include_in_toc true
      title "Chapter 1"
      initialize_with { StorySection.new(title: title,
                                         story:title,
                                         include_in_toc: include_in_toc,
                                         story: story) }
    end
  end

end

require "mocha/setup"