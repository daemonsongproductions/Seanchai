class Guest < Role

  protected

  def role_permit(user)
    Permits::GuestPermit.new(user)
  end


end