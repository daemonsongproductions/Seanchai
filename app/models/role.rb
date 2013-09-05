class Role
  include Mongoid::Document
  embedded_in :user

  def permissions_for(user)
    @permit ||= role_permit(user)
  end

  protected

  def role_permit(user)
    BasePermit.new
  end

end