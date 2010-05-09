require 'spec_helper'

describe User do
  before(:each) do

  end

  def protected_attributes
    { :password => 'password',
      :password_salt => 'salt',
      :user_type_id  => '1'

    }
  end

  def correct_password
    "password"
  end

  it "should not allow password, password_salt or user_type_id to be set via mass assignment" do
    user = User.new(protected_attributes)
    user.password.should be nil
    user.password_salt.should be nil
    user.user_type_id.should be nil
  end

  it "should set the password_salt when the password is set" do
    user = User.new
    user.password = 'password'
    user.password_salt.should_not be nil
  end

  it 'should encrypt and salt the password' do
    user = User.new
    user.password = correct_password
    user.password.should_not match correct_password
    user.password.should_not match User.encrypt_password(correct_password, '')
    user.password.should match User.encrypt_password(correct_password, user.password_salt)
  end

  describe "Is Password Correct" do

    def incorrect_password
      "invalid"
    end

    def user_with_password
      user = User.new
      user.password = correct_password
      user
    end

    it "should return true if the supplied password matches the saved password" do
      user = user_with_password
      user.is_password?(correct_password).should be true
    end

    it "should return false if the supplied password does not match the saved password" do
      user = user_with_password
      user.is_password?(incorrect_password).should be false      
    end

  end


end
