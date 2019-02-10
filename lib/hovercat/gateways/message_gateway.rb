require 'hovercat'
require 'hovercat/models/message_retry'
require 'hovercat/publishers/publisher'
require 'hovercat/exceptions/unable_to_send_message_error'

module Hovercat
  module Gateways
    class MessageGateway
      def send(params)
        header = params[:header] || {}
        exchange = params[:exchange] || Hovercat::CONFIG[:exchange]
        publisher = params[:publisher] || Hovercat::Publishers::Publisher.new
        message = params[:message]

        message_attributes = {payload: message.to_json, header: header, routing_key: message.routing_key, exchange: exchange}
        begin
          unless publisher.publish(message_attributes).ok?
            Hovercat::Models::MessageRetry.create!(message_attributes)
          end
        rescue StandardError => e
          raise Hovercat::Exceptions::UnableToSendMessageError.new(e)
        end
      end
    end
  end
end