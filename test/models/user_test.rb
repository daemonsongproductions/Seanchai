require "test_helper"

class UserTest < MiniTest::Unit::TestCase
  include Mongoid::Matchers

  def test_sanity
    flunk "Need real tests"
  end

end

describe User do
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
    User.must have_field(:name)
    User.must have_field(:name)
    User.must have_field(:name)
  end

  it "should not have unencrypted password fields" do
    User.wont have_field(:password)
    User.wont have_field(:password_confirmation)
  end

  it "should embed role" do
    User.must embed_one(:role)
  end

  it "should have many created stories" do
    User.must have_many(:created_stories)
  end

end