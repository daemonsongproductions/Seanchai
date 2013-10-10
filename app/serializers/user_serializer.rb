class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :name, :permit, :editable

  def permit
    object.role.permissions_for(object).name
  end

  def editable
    current_user.role.permissions_for(current_user).allow?(:users, :edit, object)
  end

  def administrable
    current_user.role.permissions_for(current_user).allow_param?(:topic, :role)
  end

end