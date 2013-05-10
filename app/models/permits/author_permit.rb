class AuthorPermit < BasePermit

  def initialize(user)
    allow :stories, [:index, :show]
    allow :story_sections, [:index, :show]
  end

end