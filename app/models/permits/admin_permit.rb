class AdminPermit < BasePermit

  def initialize(user)
    @allow_all = true
  end

end