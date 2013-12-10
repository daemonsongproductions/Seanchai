class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html, :json
  helper_method :current_user_json

  delegate :allow?, to: :current_permission
  helper_method :allow?

  delegate :allow_param?, to: :current_permission
  helper_method :allow_param?

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :authorize


  def current_user
    super || guest_user
  end

  def guest_user
    User.find(session[:guest_user_id].nil? ? session[:guest_user_id] = User.guest_user.id : session[:guest_user_id])
  end

  def current_permission
    @current_permission ||= current_user.permissions
  end

  def current_resource
    nil
  end

  def authorize
    if current_permission.allow?(params[:controller], params[:action], current_resource)
      current_permission.permit_params! params
    else
      redirect_to root_url, alert: "Not authorized."
    end
  end

  def current_user_json
    if current_user
      UserSerializer.new(current_user, :scope => current_user, :scope_name => :current_user, :root => false).to_json
    else
      {}.to_json
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
  end

end
