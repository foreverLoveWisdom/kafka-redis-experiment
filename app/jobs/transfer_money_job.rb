# frozen_string_literal: true

# app/jobs/transfer_money_job.rb
class TransferMoneyJob < ApplicationJob
  queue_as :default

  def perform(transfer_id)
    Rails.logger.info "🔁 [TransferMoneyJob] Running for transfer_id=#{transfer_id}"

    transfer = Transfer.find(transfer_id)

    Rails.logger.info "💸 Transferring #{transfer.amount} from #{transfer.from} to #{transfer.to}"

    KafkaProducer.publish("money_transferred", {
      from: transfer.from,
      to: transfer.to,
      amount: transfer.amount,
      at: Time.now.to_s
    })

    Rails.logger.info "📤 [Kafka] Published money_transferred for transfer_id=#{transfer.id}"
  end
end
