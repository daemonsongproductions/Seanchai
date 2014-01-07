class Permits::MemberPermit < Permits::BasePermit
  include Permits::BasePermissions

  def initialize(user)
    base_permissions
    allow :stories, [:index, :show, :create]
    allow :stories, [:edit, :update] do |story|
      story.creator.id == user.id
    end
    allow :story_sections, [:index, :show]
    allow :story_sections, [:create] do |story|
      story.creator.id == user.id
    end
    allow :story_sections, [:edit, :update] do |story_section|
      story_section.story.creator.id = user.id
    end
    allow :users, [:update] do |user_record|
      user_record.id == user.id
    end


    allow_param :story, :title
    allow_param :story, :creator
    allow_param :story, :description
    allow_param :story, :license
    allow_param :story, :copyright


  end

  def name
    "member"
  end

end