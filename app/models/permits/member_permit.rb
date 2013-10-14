class Permits::MemberPermit < Permits::BasePermit
  include Permits::BasePermissions

  def initialize(user)
    base_permissions
    allow :stories, [:index, :show]
    allow :story_sections, [:index, :show, :edit]
    allow :users, [:update] do |user_record|
      user_record.id == user.id
    end

  end

  def name
    "member"
  end

end