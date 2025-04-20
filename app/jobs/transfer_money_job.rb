# frozen_string_literal: true

# app/jobs/transfer_money_job.rb
class TransferMoneyJob < ApplicationJob
  queue_as :default

  def perform(transfer_id)
    transfer = Transfer.find(transfer_id)

    # Fan out using Sidekiq directly
    UpdateLedgerJob.perform_later(transfer.from, transfer.to, transfer.amount)
    CheckFraudJob.perform_later(transfer.from, transfer.to, transfer.amount)
    NotificationJob.perform_later(transfer.to, transfer.from, transfer.amount)
    LoggingJob.perform_later("Transfer ##{transfer.id} completed at #{Time.current}")
  end
end
