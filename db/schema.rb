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

ActiveRecord::Schema.define(version: 2020_09_17_225925) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ddcs", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_ddcs_on_name"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "samples", force: :cascade do |t|
    t.uuid "uuid"
    t.string "topic", null: false
    t.jsonb "data", default: "{}", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ddc"
    t.string "sequence"
    t.time "timestamp"
    t.jsonb "headers"
    t.index ["created_at", "ddc", "uuid"], name: "index_samples_on_created_at_and_ddc_and_uuid"
    t.index ["created_at", "topic"], name: "index_samples_on_created_at_and_topic"
    t.index ["created_at", "uuid"], name: "index_samples_on_created_at_and_uuid"
    t.index ["created_at"], name: "index_samples_on_created_at"
    t.index ["data"], name: "index_samples_on_data", using: :gin
    t.index ["ddc", "created_at"], name: "index_samples_on_ddc_and_created_at"
    t.index ["ddc"], name: "index_samples_on_ddc"
    t.index ["headers"], name: "index_samples_on_headers", using: :gin
    t.index ["sequence"], name: "index_samples_on_sequence"
    t.index ["timestamp"], name: "index_samples_on_timestamp"
    t.index ["topic"], name: "index_samples_on_topic"
    t.index ["uuid"], name: "index_samples_on_uuid"
  end

end
