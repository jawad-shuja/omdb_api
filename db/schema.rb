# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_01_050703) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "expired_at", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "movie_data", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.json "ombd_meta"
    t.datetime "last_modified_at"
    t.uuid "movie_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_movie_data_on_movie_id"
  end

  create_table "movies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "omdb_reference"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "price"
  end

  create_table "reviews", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "rating", limit: 2
    t.uuid "movie_id", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_reviews_on_movie_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "shows", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "show_time"
    t.uuid "movie_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_shows_on_movie_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role", limit: 2, default: 2
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "movie_data", "movies"
  add_foreign_key "reviews", "movies"
  add_foreign_key "reviews", "users"
  add_foreign_key "shows", "movies"
end
