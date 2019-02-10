require 'hovercat'
require 'hovercat/models/message_retry'

module Hovercat
  module Senders
    class RetryMessagesSender
      def send(publisher)
        messages = Hovercat::Models::MessageRetry.order('updated_at').limit(Hovercat::CONFIG[:retry_number_of_messages])
        messages.each do |message|
          message.with_lock do
            publisher.publish(payload: message.payload, header: message.header, routing_key: message.routing_key, exchange: message.exchange).process_message(message)
          end
        end
      end
    end
  end
end