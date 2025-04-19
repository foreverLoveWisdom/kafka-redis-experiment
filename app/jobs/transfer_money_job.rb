# frozen_string_literal: true

# app/jobs/transfer_money_job.rb
class TransferMoneyJob < ApplicationJob
  queue_as :default

  def perform(transfer_id)
    transfer = Transfer.find(transfer_id)

    puts "💸 Transferring $#{transfer.amount} from #{transfer.from} to #{transfer.to}"

    # Fan out using Sidekiq directly
    UpdateLedgerJob.perform_later(transfer.from, transfer.to, transfer.amount)
    CheckFraudJob.perform_later(transfer.from, transfer.to, transfer.amount)
    SendNotificationJob.perform_later(transfer.to, transfer.from, transfer.amount)

    puts '✅ Fan-out jobs enqueued'
  end
end
