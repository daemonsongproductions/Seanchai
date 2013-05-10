class Author < Role


  protected

  def permit_class
    AuthorPermit
  end

end