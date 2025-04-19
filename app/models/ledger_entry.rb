# frozen_string_literal: true

class LedgerEntry < ApplicationRecord
  belongs_to :bank_account_from, class_name: 'BankAccount'
  belongs_to :bank_account_to, class_name: 'BankAccount'
end
