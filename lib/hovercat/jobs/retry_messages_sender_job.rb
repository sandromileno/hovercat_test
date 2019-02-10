require 'hovercat'
require 'hovercat/publishers/publisher'
require 'hovercat/senders/retry_messages_sender'

module Hovercat
  module Jobs
    class RetryMessagesSenderJob
      queue_as :default

      def perform(publisher = Hovercat::Publishers::Publisher.new)
        publisher = publisher || Hovercat::Publishers::Publisher.new
        begin
          Hovercat::Senders::RetryMessagesSender.new.send(publisher)
        rescue StandardError
        ensure
          self.class.set(wait: Hovercat::CONFIG[:retry_delay_in_s].second).perform_later()
        end
      end
    end
  end
end
