class Member < Role


  protected

  def permit_class
    MemberPermit
  end

end