class Guest < Role

  protected

  def permit_class
    GuestPermit
  end

end