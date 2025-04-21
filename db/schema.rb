# frozen_string_literal: true

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

ActiveRecord::Schema[8.0].define(version: 20_250_421_034_828) do
  create_table 'bank_accounts', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.integer 'balance'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_bank_accounts_on_user_id'
  end

  create_table 'ledger_entries', force: :cascade do |t|
    t.integer 'amount'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'bank_account_from_id'
    t.integer 'bank_account_to_id'
    t.index ['bank_account_from_id'], name: 'index_ledger_entries_on_bank_account_from_id'
    t.index ['bank_account_to_id'], name: 'index_ledger_entries_on_bank_account_to_id'
  end

  create_table 'notifications', force: :cascade do |t|
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id', null: false
    t.string 'channel', null: false
    t.string 'template_key', null: false
    t.json 'payload', default: {}, null: false
    t.string 'status', default: 'unread'
    t.datetime 'delivered_at'
    t.index ['user_id'], name: 'index_notifications_on_user_id'
  end

  create_table 'transfers', force: :cascade do |t|
    t.string 'from'
    t.string 'to'
    t.integer 'amount'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'bank_accounts', 'users'
  add_foreign_key 'ledger_entries', 'bank_accounts', column: 'bank_account_from_id'
  add_foreign_key 'ledger_entries', 'bank_accounts', column: 'bank_account_to_id'
  add_foreign_key 'notifications', 'users'
end
