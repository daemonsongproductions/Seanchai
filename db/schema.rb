# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100510122948) do

  create_table "chapters", :force => true do |t|
    t.string   "title"
    t.integer  "story_id"
    t.integer  "status_id"
    t.datetime "publish_date"
    t.string   "parent_type"
    t.integer  "parent_id"
    t.string   "display_after_type"
    t.integer  "display_after_id"
    t.integer  "user_id"
    t.text     "post"
    t.text     "abstract"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "section_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", :force => true do |t|
    t.string   "title"
    t.integer  "story_id"
    t.integer  "section_type_id"
    t.string   "parent_type"
    t.integer  "parent_id"
    t.integer  "display_after_id"
    t.text     "synposis"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_after_type"
  end

  create_table "statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.text     "synopsis"
    t.text     "copyright"
    t.text     "license"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_level"
  end

  create_table "users", :force => true do |t|
    t.integer  "user_type_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password"
    t.text     "biography"
    t.string   "display_name"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_salt"
  end

end
