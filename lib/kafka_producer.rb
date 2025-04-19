# lib/kafka_producer.rb
module KafkaProducer
  # You can memoize the producer instance
  def self.producer
        @producer ||= WaterDrop::Producer.new do |config|
          config.deliver = true
          config.kafka = {
            'bootstrap.servers': "localhost:9092",
            'request.required.acks': 1
          }
    end
  end

  def self.publish(topic, data)
    producer.produce_async(payload: data.to_json, topic: topic)
  end
end
