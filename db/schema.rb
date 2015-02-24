# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150112055403) do

  create_table "admin_roles", force: true do |t|
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "affiliations", force: true do |t|
    t.integer  "branch_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignments", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "badges", force: true do |t|
    t.integer  "awardable_id"
    t.string   "awardable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "branches", force: true do |t|
    t.integer  "affiliation_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "businesses", force: true do |t|
    t.string   "name"
    t.string   "website"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "business_type"
    t.string   "industry"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "profile_photo_id"
    t.string   "phone"
    t.string   "email"
    t.integer  "cover_photo_id"
  end

  create_table "connections", force: true do |t|
    t.integer  "user_id"
    t.string   "relationship"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "connect_to_id"
    t.string   "type"
    t.integer  "business_id"
  end

  create_table "emails", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flags", force: true do |t|
    t.string   "flaggable_type"
    t.integer  "flaggable_id"
    t.integer  "user_id"
    t.text     "description"
    t.integer  "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "relationship"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "pending"
  end

  create_table "generic_entities", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interactions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "locatable_type"
    t.integer  "locatable_id"
  end

  create_table "mentor_roles", force: true do |t|
    t.integer  "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_polies", force: true do |t|
    t.integer  "user_id"
    t.integer  "business_id"
    t.text     "subject"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_recipients", force: true do |t|
    t.integer  "message_id"
    t.integer  "user_id"
    t.integer  "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "user_id"
    t.integer  "business_id"
    t.text     "subject"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monologue_posts", force: true do |t|
    t.integer  "posts_revision_id"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monologue_posts_revisions", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "url"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "monologue_posts_revisions", ["id"], name: "index_monologue_posts_revisions_on_id", unique: true
  add_index "monologue_posts_revisions", ["post_id"], name: "index_monologue_posts_revisions_on_post_id"
  add_index "monologue_posts_revisions", ["published_at"], name: "index_monologue_posts_revisions_on_published_at"

  create_table "monologue_tags", force: true do |t|
    t.string "name"
  end

  create_table "monologue_users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ownerships", force: true do |t|
    t.integer  "user_id"
    t.integer  "business_id"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "type"
  end

  create_table "points", force: true do |t|
    t.integer  "score"
    t.integer  "user_id"
    t.integer  "business_id"
    t.string   "pointable_type"
    t.integer  "pointable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.integer  "business_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.integer  "parent_id"
    t.text     "subject"
  end

  create_table "posts_tags", id: false, force: true do |t|
    t.integer "post_id"
    t.integer "tag_id"
  end

  create_table "read_marks", force: true do |t|
    t.integer  "readable_id"
    t.integer  "user_id",                  null: false
    t.string   "readable_type", limit: 20, null: false
    t.datetime "timestamp"
  end

  add_index "read_marks", ["user_id", "readable_type", "readable_id"], name: "index_read_marks_on_user_id_and_readable_type_and_readable_id"

  create_table "reviews", force: true do |t|
    t.string   "reviewable_type"
    t.integer  "reviewable_id"
    t.text     "subject"
    t.text     "content"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roleable_id"
    t.string   "roleable_type"
  end

  create_table "scores", force: true do |t|
    t.integer  "score"
    t.string   "scoreable_type"
    t.integer  "storeable_id"
    t.integer  "total_votes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "zip"
    t.boolean  "is_veteran"
    t.integer  "profile_photo_id"
    t.string   "city"
    t.text     "work"
    t.string   "website"
    t.text     "about"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
