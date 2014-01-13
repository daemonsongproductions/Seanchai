class StorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :copyright, :editable, :creator_id, :story_sections

  def id
    object.slug
  end

  def permit
    object.role.permissions_for(object).name
  end

  def editable
    current_user.role.permissions_for(current_user).allow?(:stories, :edit, object)
  end

  def creator_id
    object.creator.username
  end

  def story_sections
    object.story_sections.map { |section| section.slug }
  end

end