# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  filter_parameter_logging :password
  before_filter :set_theme
  layout 'default'

  def set_theme
    self.view_paths = ::ActionController::Base.view_paths.dup.unshift("#{RAILS_ROOT}/themes/default/views")
  end

  def author
    user_is_authorized_for(UserType.author)
  end

  def user_is_authorized_for(user_type)
    @authorized = false
    return unless session[:user_id]
    user = User.find(session[:user_id])
    user.for_atleast(user_type) {@authorized = true}
  end



  

end
