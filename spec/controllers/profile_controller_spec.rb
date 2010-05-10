require 'spec_helper'

describe ProfileController do

  before :each do
    @params = { :email => 'email@email.com', :password => 'password'}
  end

  it "should add a new user with the supplied parameters" do

    user = User.new
    User.stub(:new).and_return(user)
    User.stub(:save).and_return(true)
    post :create, @params
    
    user.email.should match @params[:email]
    user.password.should match User.encrypt_password(@params[:password], user.password_salt)
  end


end
