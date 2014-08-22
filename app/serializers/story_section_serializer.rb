class StorySectionSerializer < ActiveModel::Serializer
  attributes :id, :slug, :order, :title, :body, :include_in_toc,
             :editable, :story_id, :story_slug, :creator_id, :partial,
             :status_id, :next_section, :previous_section

  def id
    object.id.to_s
  end

  def slug
    object.slug
  end

  def body
    attribute_present?('body') ? object.body : ""
  end

  def editable
    current_user.role.permissions_for(current_user).allow?(:story_sections, :update, object)
  end

  def creator_id
    object.creator.username
  end

  def story_id
    object.story.id.to_s
  end

  def story_slug
    object.story.slug
  end

  def partial
    attribute_present?('body')
  end

  def next_section
    # TODO: When Mongoid::Orderable udpates, use this code:
    # object.lower_items.first.id unless object.last?
    object.story.story_sections[object.order].order unless object.last?
  end

  def previous_section
    # TODO: When Mongoid::Orderable udpates, use this code:
    # object.higher_items.first.id unless object.first?
    object.story.story_sections[object.order - 2].order unless object.first?
  end

  def attribute_present?(name)
    object.attribute_present?(name)
  rescue ActiveModel::MissingAttributeError
    return false
  end

end