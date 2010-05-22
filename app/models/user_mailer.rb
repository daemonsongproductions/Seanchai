class UserMailer < ActionMailer::Base

  def forgot_my_password(user, new_password)
    recipients user.email
    from "seanchai@daemonsong.com"
    subject "Password Reset"
    body :user => user, :new_password => new_password
  end

end
