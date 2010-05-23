require 'spec_helper'

describe "Reset Password Confirmation" do

  it 'should display the password reset confirmation' do
    render 'login/reset_confirmation'
    response.should have_tag('div#confirmation_div')
    
  end

end
