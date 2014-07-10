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

  describe "default role" do

    before :all do
      @user = User.create!(username: "test", email: "test@test.com", password: "password", password_confirmation: "password")
    end

    it "should set a default role" do
      refute_nil @user.role
    end

    it "should set default role to Member" do
      assert_equal @user.role.class, Member.new.class
    end

  end



end