# frozen_string_literal: true

class SendNotificationJob < ApplicationJob
  queue_as :default

  def perform(to, from, amount)
    puts "📨 Sent notification to #{to} for receiving $#{amount} from #{from}"
  end
end
