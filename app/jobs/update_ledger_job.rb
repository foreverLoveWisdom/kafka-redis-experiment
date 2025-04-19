# frozen_string_literal: true

class UpdateLedgerJob < ApplicationJob
  queue_as :default

  def perform(from, to, amount)
    puts "💰 Ledger updated: #{from} → #{to}, $#{amount}"
  end
end
