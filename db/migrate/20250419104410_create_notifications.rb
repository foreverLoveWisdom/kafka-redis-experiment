# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :notifications do |t|
      t.string :recipient
      t.string :content

      t.timestamps
    end
  end
end
