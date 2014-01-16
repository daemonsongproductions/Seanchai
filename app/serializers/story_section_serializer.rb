class StorySectionSerializer < ActiveModel::Serializer
  attributes :id, :slug, :order, :title, :body, :include_in_toc,
             :editable, :story_id, :story_slug, :creator_id, :partial,
             :status_id, :next_section, :previous_section

  def id
    object.id
  end

  def slug
    object.slug
  end

  def body
    object.body? ? object.body : ""
  end

  def editable
    current_user.role.permissions_for(current_user).allow?(:story_sections, :update, object)
  end

  def creator_id
    object.creator.username
  end

  def story_id
    object.story.id
  end

  def story_slug
    object.story.slug
  end

  def partial
    !object.body?
  end

  def next_section
    # TODO: When Mongoid::Orderable udpates, use this code:
    # object.lower_items.first.id unless object.last?
    object.story.story_sections[object.order].id unless object.last?
  end

  def previous_section
    # TODO: When Mongoid::Orderable udpates, use this code:
    # object.higher_items.first.id unless object.first?
    object.story.story_sections[object.order - 2].id unless object.first?
  end

end