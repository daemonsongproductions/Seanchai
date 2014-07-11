require "test_helper"

class Devise::RegistrationsControllerTest < MiniTest::Unit::TestCase

  def test_sanity
    skip("leaving this as an example of unit test syntax in minitest")
  end

end

describe Devise::RegistrationsController do


  before :each do
    @user_options =  {username: "user",
                      email: "email@email.com",
                      password: 'password',
                      password_confirmation: 'password'}
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "create" do

    it "should return unprocessable if selected role not present" do
      set_guest_user
      user = User.create(@user_options)
      User.expects(:new_with_session).returns(user)
      post :create, format: 'json', user: @user_options
      assert_response :unprocessable_entity
    end

    it "should return unprocessable if an invalid role is passed" do
      set_guest_user
      user_options_with_role = @user_options.merge(selected_role: 'admin')
      user = User.create(user_options_with_role)
      User.expects(:new_with_session).returns(user)
      post :create, format: 'json', user: user_options_with_role
      assert_response :unprocessable_entity
    end

    it "should return successfully if a user chooses to be a reader" do
      set_guest_user
      user_options_with_role = @user_options.merge(selected_role: 'reader')
      user = User.create(user_options_with_role)
      User.expects(:new_with_session).returns(user)
      post :create, format: 'json', user: user_options_with_role
      assert_response :created
    end

    it "should return successfully if a user chooses to be a creator" do
      set_guest_user
      user_options_with_role = @user_options.merge(selected_role: 'creator')
      user = User.create(user_options_with_role)
      User.expects(:new_with_session).returns(user)
      post :create, format: 'json', user: user_options_with_role
      assert_response :created
    end

  end

end