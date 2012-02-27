# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "assets", :force => true do |t|
    t.integer "assetable_id"
    t.string  "assetable_type", :limit => 50
    t.integer "price"
    t.integer "store_id",                     :null => false
  end

  add_index "assets", ["store_id"], :name => "index_assets_store"

  create_table "categories", :force => true do |t|
    t.string   "name",       :limit => 50
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "category_videos", :force => true do |t|
    t.integer "category_id", :null => false
    t.integer "video_id",    :null => false
  end

  add_index "category_videos", ["category_id"], :name => "index_category_videos_category"
  add_index "category_videos", ["video_id"], :name => "index_category_videos_video"

  create_table "images", :force => true do |t|
    t.string   "photo",               :limit => 50
    t.string   "source_file_name",    :limit => 50
    t.string   "source_content_type", :limit => 50
    t.integer  "source_file_size"
    t.datetime "source_updated_at"
  end

  create_table "line_items", :force => true do |t|
    t.integer "quantity"
    t.integer "total_price"
    t.integer "asset_id",    :null => false
    t.integer "order_id",    :null => false
  end

  add_index "line_items", ["asset_id"], :name => "index_line_items_asset"
  add_index "line_items", ["order_id"], :name => "index_line_items_order"

  create_table "order_infos", :force => true do |t|
    t.string  "token",    :limit => 50
    t.string  "status",   :limit => 50
    t.integer "amount"
    t.string  "currency", :limit => 50
    t.integer "order_id",               :null => false
  end

  add_index "order_infos", ["order_id"], :name => "index_order_infos_order"

  create_table "orders", :force => true do |t|
    t.string  "name",     :limit => 50
    t.text    "address"
    t.string  "email",    :limit => 50
    t.string  "pay_type", :limit => 50
    t.boolean "confirm"
  end

  create_table "other_video_images", :force => true do |t|
    t.string  "image",          :limit => 50
    t.integer "file_size"
    t.string  "file_name",      :limit => 50
    t.integer "other_video_id",               :null => false
  end

  add_index "other_video_images", ["other_video_id"], :name => "index_other_video_images_other_video"

  create_table "other_videos", :force => true do |t|
    t.string "demo_video_path", :limit => 50
    t.string "title",           :limit => 50
    t.text   "description"
    t.string "main_video_mp4",  :limit => 50
    t.string "main_video_mpeg", :limit => 50
    t.string "main_video_wmv",  :limit => 50
  end

  create_table "role_users", :force => true do |t|
    t.integer "role_id", :null => false
    t.integer "user_id", :null => false
  end

  add_index "role_users", ["role_id"], :name => "index_role_users_role"
  add_index "role_users", ["user_id"], :name => "index_role_users_user"

  create_table "roles", :force => true do |t|
    t.string "name", :limit => 50
  end

  execute "insert into roles (name) values ('admin')"
  execute "insert into roles (name) values ('producer')"
  execute "insert into roles (name) values ('consumer')"


  execute "insert into categories (name) values ('category1')"
  execute "insert into categories (name) values ('category2')"
  execute "insert into categories (name) values ('category3')"



  create_table "stores", :force => true do |t|
    t.text    "description"
    t.string  "title",       :limit => 50
    t.integer "user_id",                   :null => false
  end

  add_index "stores", ["user_id"], :name => "index_stores_user"

  create_table "texts", :force => true do |t|
    t.text     "body"
    t.string   "title",      :limit => 50
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :limit => 50,                  :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.datetime "remember_created_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username",               :limit => 50
    t.string   "first_name",             :limit => 50
    t.string   "last_name",              :limit => 50
  end

  create_table "video_images", :force => true do |t|
    t.string   "photo",               :limit => 50
    t.string   "source_file_name",    :limit => 50
    t.string   "source_content_type", :limit => 50
    t.integer  "source_file_size"
    t.datetime "source_updated_at"
    t.integer  "video_id",                          :null => false
  end

  add_index "video_images", ["video_id"], :name => "index_video_images_video"

  create_table "videos", :force => true do |t|
    t.string   "source_file_name",    :limit => 50
    t.string   "source_content_type", :limit => 50
    t.integer  "source_file_size"
    t.datetime "source_updated_at"
    t.string   "title",               :limit => 50
    t.text     "description"
  end

end
