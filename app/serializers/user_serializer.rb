class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :name, :permit

  def permit
    object.role.permissions_for(object).name
  end

end