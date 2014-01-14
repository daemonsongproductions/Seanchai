class StorySectionSerializer < ActiveModel::Serializer
  attributes :id, :slug, :order, :title, :body, :include_in_toc, :editable, :story_id, :creator_id

  def id
    object.id
  end

  def editable
    current_user.role.permissions_for(current_user).allow?(:story_sections, :update, object)
  end

  def creator_id
    object.story.creator.username
  end

  def story_id
    object.story.id
  end

end