class AdminPermit < Permits::BasePermit

  def initialize(user)
    @allow_all = true
  end

end