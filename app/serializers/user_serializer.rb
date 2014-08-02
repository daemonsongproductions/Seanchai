class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :name, :permit, :editable, :role

  def id
    object.username
  end

  def permit
    object.role.permissions_for(object).name
  end

  def role
    object.role.class.to_s.downcase
  end

  def editable
    current_user.role.permissions_for(current_user).allow?(:users, :edit, object)
  end

end