# frozen_string_literal: true

# script/ledger_consumer.rb
require './config/environment'
require 'json'

require 'ruby-kafka'
kafka = Kafka.new(['localhost:9092'])
consumer = kafka.consumer(group_id: 'ledger-group')
consumer.subscribe('money_transferred')

puts '📚 LedgerService started...'

consumer.each_message do |msg|
  data = JSON.parse(msg.value)
  LedgerEntry.create!(
    bank_account_from_id: data['from'],
    bank_account_to_id: data['to'],
    amount: data['amount']
  )
  puts "✅ Ledger updated: #{data['from']} → #{data['to']} | $#{data['amount']}"
end
