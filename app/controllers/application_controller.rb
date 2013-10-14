class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html, :json
  helper_method :current_user_json

  delegate :allow?, to: :current_permission
  helper_method :allow?

  delegate :allow_param?, to: :current_permission
  helper_method :allow_param?

  before_filter :set_guest_user
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :authorize


  def set_guest_user
    sign_in(User.guest_user) if current_user.blank?
  end

  def current_permission
    @current_permission ||= current_user.permissions
  end

  def current_resource
    nil
  end

  def authorize
    logger.debug(params[:controller])
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
