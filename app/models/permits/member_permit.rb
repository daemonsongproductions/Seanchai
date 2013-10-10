class Permits::MemberPermit < Permits::BasePermit

  def initialize(user)
    allow :stories, [:index, :show]
    allow :story_sections, [:index, :show]
    allow :users, [:index, :show]
    allow :users, [:edit] do |user_record|
      user_record.id == user.id
    end
  end

  def name
    "member"
  end

end