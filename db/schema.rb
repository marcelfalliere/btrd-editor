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

ActiveRecord::Schema.define(:version => 20120525123237) do

  create_table "elements", :force => true do |t|
    t.integer  "type_id"
    t.integer  "niveau_id"
    t.integer  "x"
    t.integer  "y"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mainconfigs", :force => true do |t|
    t.string   "root"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

# Could not dump table "niveaus" because of following StandardError
#   Unknown type 'bool' for column 'isDeleted'

  create_table "options", :force => true do |t|
    t.integer  "element_id"
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "types", :force => true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cssClass"
    t.string   "xmlTag"
    t.boolean  "perfVoisin"
    t.boolean  "isSegment"
  end

end
