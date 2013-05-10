class Role
  include Mongoid::Document
  embedded_in :user

  def permissions_for(user)
    @permit ||= permit_class.new(user)
  end

  protected

  def permit_class
    BasePermit
  end

end