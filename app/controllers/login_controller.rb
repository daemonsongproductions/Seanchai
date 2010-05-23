class LoginController < ApplicationController

  def forgot_password
    
  end

  def reset_password
    user = User.find_by_email(params[:email])

    if user
      new_password = user.create_new_password
      UserMailer.deliver_forgot_my_password(user, new_password) if user.save
    end

    redirect_to(password_reset_confirmation_path)
  end

  def reset_confirmation
    
  end

end
