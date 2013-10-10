class Admin < Role


  protected

  def role_permit(user)
    Permits::AdminPermit.new(user)
  end


end