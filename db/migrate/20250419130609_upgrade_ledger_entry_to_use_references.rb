# frozen_string_literal: true

class UpgradeLedgerEntryToUseReferences < ActiveRecord::Migration[8.0]
  def change
    remove_column :ledger_entries, :from, :string
    remove_column :ledger_entries, :to, :string

    add_reference :ledger_entries, :bank_account_from, foreign_key: { to_table: :bank_accounts }
    add_reference :ledger_entries, :bank_account_to, foreign_key: { to_table: :bank_accounts }
  end
end
