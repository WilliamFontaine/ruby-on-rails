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

ActiveRecord::Schema[8.0].define(version: 2025_01_08_082923) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "nom"
    t.string "prenom"
    t.text "adresse"
    t.string "telephone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "savs", force: :cascade do |t|
    t.string "produit"
    t.string "fournisseur"
    t.date "date_depot"
    t.date "date_retour"
    t.date "date_enlevement"
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_savs_on_client_id"
  end

  add_foreign_key "savs", "clients"
end
