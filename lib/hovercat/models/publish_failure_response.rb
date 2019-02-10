require 'hovercat'
require 'hovercat/gateways/team_notifier_gateway'

module Hovercat
  module Models
    class PublishFailureResponse
      def process_message(message)
        message.increment!(:retry_count)
        if message.too_many_retries?(Hovercat::CONFIG[:retry_attempts])
          Hovercat::Gateways::TeamNotifierGateway.new.notify(message)
        end
      end

      def ok?
        false
      end
    end
  end
end
