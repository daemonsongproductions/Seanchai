class LoginController < ApplicationController

  def login

  end

  def authenticate

    user = User.find_by_email(params[:email])
    authentic = user.is_password?(params[:password]) if user

    if authentic
      session[:user_id] = user.id
      flash[:notice] = "You have successfully logged in!"
    else
      session[:user_id] = nil
      flash[:error] = "You've entered an incorrect username or password."
    end
    
    

  end

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
