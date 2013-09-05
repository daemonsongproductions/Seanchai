class Member < Role


  protected

  def role_permit(user)
    Permits::MemberPermit.new(user)
  end

end