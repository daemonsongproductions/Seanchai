class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.string :title
      t.integer :story_id
      t.integer :section_type_id
      t.string :parent_type
      t.integer :parent_id
      t.integer :display_after_id
      t.text :synposis

      t.timestamps
    end
  end

  def self.down
    drop_table :sections
  end
end
