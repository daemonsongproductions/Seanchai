class AddDisplayAfterTypeToSection < ActiveRecord::Migration
  def self.up
    add_column Section, :display_after_type, :string
  end

  def self.down
    remove_column Section, :display_after_type
  end
end
