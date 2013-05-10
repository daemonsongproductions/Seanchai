class Reader < Role


  protected

  def permit_class
    ReaderPermit
  end

end