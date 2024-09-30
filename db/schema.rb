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

ActiveRecord::Schema[7.1].define(version: 2024_09_30_082505) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.bigint "recipes_id", null: false
    t.bigint "ingredients_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredients_id"], name: "index_recipe_ingredients_on_ingredients_id"
    t.index ["recipes_id"], name: "index_recipe_ingredients_on_recipes_id"
  end

  create_table "recipe_tags", force: :cascade do |t|
    t.bigint "recipes_id", null: false
    t.bigint "tags_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipes_id"], name: "index_recipe_tags_on_recipes_id"
    t.index ["tags_id"], name: "index_recipe_tags_on_tags_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "title"
    t.string "main_ingredient"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "recipe_ingredients", "ingredients", column: "ingredients_id"
  add_foreign_key "recipe_ingredients", "recipes", column: "recipes_id"
  add_foreign_key "recipe_tags", "recipes", column: "recipes_id"
  add_foreign_key "recipe_tags", "tags", column: "tags_id"
end
