require "test_helper"

class UserTest < MiniTest::Unit::TestCase

  def test_sanity
    skip("leaving this as an example of unit test syntax in minitest")
  end

end

describe User do

  describe "guest user" do

    it "should return a guest user" do
      refute_nil User.guest_user
    end

    it "should return a guest user with a Guest role" do
      assert_equal User.guest_user.role.class, Guest.new.class
    end

  end

  describe "create user with proper role" do

    it "should error if no role is provided" do
      assert_raises Mongoid::Errors::Validations do
        User.create!(user_options)
      end
    end
    it "should set role to Creator" do
      @user = User.create!(user_options.merge(role: Creator.new))
      assert_equal @user.role.class, Creator.new.class
    end
    it "should set role to Reader" do
      @user = User.create!(user_options.merge(role: Reader.new))
      assert_equal @user.role.class, Reader.new.class
    end
    it "should set role to Admin" do
      @user = User.create!(user_options.merge(role: Admin.new))
      assert_equal @user.role.class, Admin.new.class
    end

  end

  def user_options
    {username: "test",
     email: "test@test.com",
     password: "password",
     password_confirmation: "password"}
  end


end