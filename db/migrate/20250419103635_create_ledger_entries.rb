# frozen_string_literal: true

class CreateLedgerEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :ledger_entries do |t|
      t.string :from
      t.string :to
      t.integer :amount

      t.timestamps
    end
  end
end
