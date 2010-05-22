class LoginController < ApplicationController

  def forgot_my_paassword
    user = User.new
    UserMailer.deliver_forgot_my_password(user, 'password')
  end

end
