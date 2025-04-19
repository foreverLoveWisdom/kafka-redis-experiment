# frozen_string_literal: true

require 'json'
require 'ruby-kafka'

kafka = Kafka.new(['localhost:9092'])
consumer = kafka.consumer(group_id: 'fraud-group')
consumer.subscribe('money_transferred')

puts '🕵️‍♂️ FraudService started...'

consumer.each_message do |msg|
  data = JSON.parse(msg.value)
  puts "🚨 FRAUD ALERT: #{data}" if data['amount'].to_i > 10_000
end
