class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.string :title
      t.integer :user_id
      t.text :synopsis
      t.text :copyright
      t.text :license

      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
