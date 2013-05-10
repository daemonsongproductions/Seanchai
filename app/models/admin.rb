class Admin < Role


  protected

  def permit_class
    AdminPermit
  end

end