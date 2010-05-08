class AddPasswordSaltToUserTable < ActiveRecord::Migration
  def self.up
    add_column User, :password_salt, :string
  end

  def self.down
    remove_column User, :password_salt
  end
end
