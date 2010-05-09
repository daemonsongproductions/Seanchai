require 'spec_helper'

describe User do
  before(:each) do
    @protected_attributes = { :password => 'password',
                              :password_salt => 'salt',
                              :user_type_id  => '1'
      
    }
  end

  it "should not allow password, password_salt or user_type_id to be set via mass assignment" do
    user = User.new(@protected_attributes)
    user.password.should be nil
    user.password_salt.should be nil
    user.user_type_id.should be nil
  end

  it "should set the password_salt when the password is set" do
    user = User.new
    user.password = 'password'
    user.password_salt.should_not be nil
  end

end
