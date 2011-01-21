# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  filter_parameter_logging :password
  before_filter :set_theme
  before_filter :current_user
  layout 'default'

  def set_theme
    self.view_paths = ::ActionController::Base.view_paths.dup.unshift("#{RAILS_ROOT}/themes/default/views")
  end

  def current_user
    session[:user_id] = -1 unless session[:user_id]
    @current_user = User.find(session[:user_id])
  end

  def requires_login
    flash[:error] = "If you want in, you'll have to login."
    redirect_to login_path unless @current_user.class != PseudoUser
  end



  

end
