class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html, :json
  helper_method :current_user_json
  before_filter :configure_permitted_parameters, if: :devise_controller?


  def current_user_json
    if current_user
      UserSerializer.new(current_user, :scope => current_user, :root => false).to_json
    else
      {}.to_json
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
  end

end
