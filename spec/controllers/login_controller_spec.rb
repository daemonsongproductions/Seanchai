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

end
