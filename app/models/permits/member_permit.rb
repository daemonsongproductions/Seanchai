class Permits::MemberPermit < Permits::BasePermit

  def initialize(user)
    allow :stories, [:index, :show]
    allow :story_sections, [:index, :show]
  end

  def name
    "member"
  end

end