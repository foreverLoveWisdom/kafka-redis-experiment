# frozen_string_literal: true

class CheckFraudJob < ApplicationJob
  queue_as :default

  def perform(from, to, amount)
    return unless amount.to_i > 10_000

    puts "🚨 FRAUD ALERT for #{from} → #{to}, $#{amount}"
  end
end
