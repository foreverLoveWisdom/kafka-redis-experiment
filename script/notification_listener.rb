# frozen_string_literal: true

require './config/environment'
require 'json'
require 'ruby-kafka'

kafka = Kafka.new(['localhost:9092'])
consumer = kafka.consumer(group_id: 'notification-group')
consumer.subscribe('money_transferred')

puts '📢 NotificationService started...'

consumer.each_message do |msg|
  data = JSON.parse(msg.value)
  Notification.create!(
    recipient: data['to'],
    content: "You received $#{data['amount']} from #{data['from']}"
  )
  puts "📨 Notified #{data['to']}"
end
