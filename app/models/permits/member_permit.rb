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
    allow :story_sections, [:update] do |story_section|
      story_section.creator.id == user.id
    end
    allow :users, [:update] do |user_record|
      user_record.id == user.id
    end


    allow_param :story, :title
    allow_param :story, :creator
    allow_param :story, :description
    allow_param :story, :license
    allow_param :story, :copyright
    allow_param :story, :status_id

    allow_param :story_section, :title
    allow_param :story_section, :body
    allow_param :story_section, :include_in_toc
    allow_param :story_section, :status_id
    allow_param :story_section, :story_id


  end

  def name
    "member"
  end

end