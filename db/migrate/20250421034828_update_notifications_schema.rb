# frozen_string_literal: true

class UpdateNotificationsSchema < ActiveRecord::Migration[8.0]
  def change
    change_table :notifications do |t|
      t.remove :recipient, :content

      t.references :user, null: false, foreign_key: true
      t.string :channel, null: false
      t.string :template_key, null: false
      t.json :payload, null: false, default: {}
      t.string :status, default: 'unread'
      t.datetime :delivered_at
    end
  end
end
