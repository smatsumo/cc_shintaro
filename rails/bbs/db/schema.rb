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

ActiveRecord::Schema.define(version: 20170912135133) do

  create_table "access", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "access_datetime", comment: "アクセス日時"
    t.integer "user_id", comment: "ユーザーID"
  end

  create_table "customers", primary_key: "customer_id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "customer_name", limit: 100
    t.string "phone_number", limit: 11
  end

  create_table "employees", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "id"
    t.string "name", limit: 100
    t.integer "age"
    t.string "post", limit: 10
    t.integer "salary"
  end

  create_table "order_details", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.integer "quantity", default: 0
  end

  create_table "orders", primary_key: "order_id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "customer_id"
    t.datetime "order_date"
  end

  create_table "products", primary_key: "product_id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "product_name", limit: 100
    t.integer "price", default: 0
  end

  create_table "students", primary_key: "student_id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "student_name", limit: 100, null: false
    t.integer "age", null: false
    t.integer "grade", null: false
    t.string "subject", limit: 10, null: false
  end

  create_table "tweets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "tweet"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
