class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :set_theme
  before_filter :current_user
  layout 'default'

  def set_theme
    self.prepend_view_path("#{::Rails.root.to_s}/themes/default/views")
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
