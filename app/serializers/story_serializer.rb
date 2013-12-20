class StorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :copyright

  def id
    object.slug
  end

  def permit
    object.role.permissions_for(object).name
  end

  def editable
    current_user.role.permissions_for(current_user).allow?(:story, :edit, object)
  end

end