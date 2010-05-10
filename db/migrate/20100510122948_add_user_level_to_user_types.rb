class AddUserLevelToUserTypes < ActiveRecord::Migration
  def self.up
    add_column UserType, :user_level, :integer
  end

  def self.down
    remove_column UserType, :user_level
  end
end
