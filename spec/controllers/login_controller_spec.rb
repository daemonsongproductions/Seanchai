require 'spec_helper'

describe LoginController do

  describe "Forgot my Password" do

    it "should email a new password when requested for the supplied email" do

      mock_user = mock(User)
      email = 'tester@test.com'
      password = 'password'

      User.should_receive(:find_by_email).with(email).and_return(mock_user)
      mock_user.should_receive(:create_new_password).and_return(password)
      mock_user.should_receive(:save).and_return(true)

      UserMailer.should_receive(:deliver_forgot_my_password).with(mock_user, password)

      post :reset_password, :email => email

    end

    it "should redirect to the confirmation page even when supplied with a nonexistant email" do

      User.should_receive(:find_by_email).and_return(nil)
      UserMailer.should_not_receive(:deliver_forgot_my_password)

      post :reset_password, :email => 'failure@failure.com'
      response.should redirect_to(:action => :reset_confirmation)
      
      end
  end

  describe "Login" do

    it "should save the user id when the supplied username/email and password pass authentication" do

      mock_user = mock(User)
      User.should_receive(:find_by_email).with('tester@test.com').and_return(mock_user)
      mock_user.should_receive(:is_password?).with('password').and_return(true)
      mock_user.should_receive(:id).and_return(0)

      post :authenticate, :email => 'tester@test.com', :password => 'password'

      session[:user_id].should be 0
      

    end

    it "should set the user id to nil and return an error when no user is found for the supplied email address" do

      session[:user_id] = 1
      User.should_receive(:find_by_email).with('tester@test.com').and_return(nil)
      post :authenticate, :email => 'tester@test.com'

      session[:user_id].should be nil
      flash[:error].should_not be nil

    end

    it "should set the user id to nil and return an error when the user is found but the password doesn't match" do
      session[:user_id] = 1
      User.should_receive(:find_by_email).with('tester@test.com').and_return(mock_user = mock(User))
      mock_user.should_receive(:is_password?).with('password').and_return(false)

      post :authenticate, :email => 'tester@test.com', :password => 'password'

      session[:user_id].should be nil
      flash[:error].should_not be nil

    end

  end

end
