require 'hovercat/connectors/bunny_connector'
require 'hovercat/models/publish_successfully_response'
require 'hovercat/models/publish_failure_response'
require 'hovercat/exceptions/unexpected_error'

module Hovercat
  module Publishers
    class Publisher
      def initialize(connector = Hovercat::Connectors::BunnyConnector.new)
        @connector = connector
      end

      def publish(params)
        response = Hovercat::Models::PublishSuccessfullyResponse.new

        begin
          @connector.publish(params)
        rescue Hovercat::Exceptions::UnexpectedError
          response = Hovercat::Models::PublishFailureResponse.new
        end

        response
      end
    end
  end
end