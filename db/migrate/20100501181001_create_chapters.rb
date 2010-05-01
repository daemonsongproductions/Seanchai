class CreateChapters < ActiveRecord::Migration
  def self.up
    create_table :chapters do |t|
      t.string :title
      t.integer :story_id
      t.integer :status_id
      t.datetime :publish_date
      t.string :parent_type
      t.integer :parent_id
      t.string :display_after_type
      t.integer :display_after_id
      t.integer :user_id
      t.text :post
      t.text :abstract

      t.timestamps
    end
  end

  def self.down
    drop_table :chapters
  end
end
