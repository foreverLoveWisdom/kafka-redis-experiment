require 'json'
require 'ruby-kafka'

kafka = Kafka.new([ "localhost:9092" ])
consumer = kafka.consumer(group_id: "fraud-group")
consumer.subscribe("money_transferred")

puts "🕵️‍♂️ FraudService started..."

consumer.each_message do |msg|
  data = JSON.parse(msg.value)
  if data["amount"].to_i > 10000
    puts "🚨 FRAUD ALERT: #{data}"
  end
end
