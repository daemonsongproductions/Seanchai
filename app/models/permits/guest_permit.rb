class Permits::GuestPermit < Permits::BasePermit

  include Permits::BasePermissions

  def initialize(user)
    base_permissions
    allow :stories, [:index, :show]
    allow :story_sections, [:index, :show]
  end

  def name
    "guest"
  end

end