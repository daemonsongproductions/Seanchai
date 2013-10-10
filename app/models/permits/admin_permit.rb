class Permits::AdminPermit < Permits::BasePermit

  def initialize(user)
    @allow_all = true
  end

  def name
    "admin"
  end

end