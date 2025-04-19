# frozen_string_literal: true

class BankAccount < ApplicationRecord
  belongs_to :user

  has_many :sent_ledger_entries,
           class_name: 'LedgerEntry',
           foreign_key: 'bank_account_from_id'

  has_many :received_ledger_entries,
           class_name: 'LedgerEntry',
           foreign_key: 'bank_account_to_id'
end
