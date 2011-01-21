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

ActiveRecord::Schema.define(:version => 20110121003651) do

  create_table "customers", :force => true do |t|
    t.string   "name",                               :null => false
    t.string   "lastname"
    t.string   "identification",                     :null => false
    t.integer  "free_monthly_copies"
    t.integer  "lock_version",        :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customers", ["identification"], :name => "index_customers_on_identification", :unique => true

  create_table "documents", :force => true do |t|
    t.string   "code",                             :null => false
    t.string   "name",                             :null => false
    t.text     "description"
    t.integer  "pages",                            :null => false
    t.integer  "lock_version",      :default => 0
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["code"], :name => "index_documents_on_code", :unique => true
  add_index "documents", ["name"], :name => "index_documents_on_name"

  create_table "documents_tags", :id => false, :force => true do |t|
    t.integer "document_id", :null => false
    t.integer "tag_id",      :null => false
  end

  add_index "documents_tags", ["document_id", "tag_id"], :name => "index_documents_tags_on_document_id_and_tag_id", :unique => true

  create_table "print_jobs", :force => true do |t|
    t.integer  "job_id",                                                       :null => false
    t.integer  "copies",                                                       :null => false
    t.decimal  "price_per_copy", :precision => 15, :scale => 2,                :null => false
    t.string   "range"
    t.integer  "document_id",                                                  :null => false
    t.integer  "print_id",                                                     :null => false
    t.integer  "lock_version",                                  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "print_jobs", ["document_id"], :name => "index_print_jobs_on_document_id"
  add_index "print_jobs", ["print_id"], :name => "index_print_jobs_on_print_id"

  create_table "prints", :force => true do |t|
    t.string   "printer",                     :null => false
    t.integer  "user_id"
    t.integer  "customer_id"
    t.integer  "lock_version", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prints", ["created_at"], :name => "index_prints_on_created_at"
  add_index "prints", ["customer_id"], :name => "index_prints_on_customer_id"
  add_index "prints", ["user_id"], :name => "index_prints_on_user_id"

  create_table "settings", :force => true do |t|
    t.string   "var",                         :null => false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type"
    t.integer  "lock_version", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], :name => "index_settings_on_thing_type_and_thing_id_and_var", :unique => true

  create_table "tags", :force => true do |t|
    t.string   "name",                        :null => false
    t.integer  "parent_id"
    t.integer  "lock_version", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], :name => "index_tags_on_name"
  add_index "tags", ["parent_id"], :name => "index_tags_on_parent_id"

  create_table "user_sessions", :force => true do |t|
    t.string   "session_id",                      :null => false
    t.string   "current_login_ip"
    t.datetime "current_login_at"
    t.datetime "last_request_at"
    t.integer  "lock_version",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                                 :null => false
    t.string   "last_name",                            :null => false
    t.string   "language",                             :null => false
    t.string   "email",                                :null => false
    t.string   "username",                             :null => false
    t.string   "crypted_password",                     :null => false
    t.string   "password_salt",                        :null => false
    t.string   "persistence_token",                    :null => false
    t.boolean  "admin",             :default => false, :null => false
    t.boolean  "enable"
    t.integer  "lock_version",      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
