require 'spec_helper'

describe 'Forgot My Password' do

  it "should render the forgot my password form" do

    render "login/forgot_password"
    response.should have_tag('form#forgot_password_form')
    response.should have_tag('input#email')
    response.should have_tag('input[type=submit]')

  end


end