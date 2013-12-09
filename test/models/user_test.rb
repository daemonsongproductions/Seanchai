require "test_helper"

class UserTest < MiniTest::Unit::TestCase
  include Mongoid::Matchers

  def test_sanity
    skip("leaving this as an example of unit test syntax in minitest")
  end

end

describe User do

  describe "User fields" do

    it "should have needed fields" do
      User.must have_field(:username)
      User.must have_field(:email)
      User.must have_field(:name)
      User.must have_field(:encrypted_password)
      User.must have_field(:reset_password_token)
      User.must have_field(:reset_password_sent_at)
      User.must have_field(:remember_created_at)
      User.must have_field(:sign_in_count)
      User.must have_field(:current_sign_in_at)
      User.must have_field(:last_sign_in_at)
      User.must have_field(:current_sign_in_ip)
      User.must have_field(:last_sign_in_ip)
      User.must have_field(:guest_user)
    end

    it "should not have unencrypted password fields" do
      User.wont have_field(:password)
      User.wont have_field(:password_confirmation)
    end
  end

  describe "User associations" do
    it "should embed role" do
      User.must embed_one(:role)
    end

    it "should have many created stories" do
      User.must have_many(:created_stories)
    end
  end

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