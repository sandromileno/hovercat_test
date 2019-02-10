require 'hovercat/gateways/message_gateway'
require 'hovercat/publishers/publisher'
require 'hovercat/models/publish_successfully_response'
require 'hovercat/models/publish_failure_response'
require 'hovercat/models/message_retry'
require 'hovercat/exceptions/unable_to_send_message_error'
require 'bunny'

RSpec.describe Hovercat::Gateways::MessageGateway do

  let(:publisher) { Hovercat::Publishers::Publisher.new }
  let(:message) { double('message', to_json: 'message_json', routing_key: 'message_routing_key') }
  subject { Hovercat::Gateways::MessageGateway.new.send(header: header, exchange: exchange, publisher: publisher, message: message) }

  context 'Only event passed and successfully published' do
    let(:header) { nil }
    let(:exchange) { nil }

    it do
      expect(publisher).to receive(:publish).with(payload: message.to_json, header: {}, routing_key: message.routing_key, exchange: Hovercat::CONFIG[:exchange]).and_return(Hovercat::Models::PublishSuccessfullyResponse.new)
      subject
    end
  end

  context 'All params set and successfully published' do
    let(:header) { {content_type: 'Application/json'} }
    let(:exchange) { 'test.exchange' }

    it do
      expect(publisher).to receive(:publish).with(payload: message.to_json, header: header, routing_key: message.routing_key, exchange: exchange).and_return(Hovercat::Models::PublishSuccessfullyResponse.new)
      subject
    end
  end

  context 'Only event passed and successfully stored to retry' do
    let(:header) { nil }
    let(:exchange) { nil }
    before do
      expect(publisher).to receive(:publish).with(payload: message.to_json, header: {}, routing_key: message.routing_key, exchange: Hovercat::CONFIG[:exchange]).and_return(Hovercat::Models::PublishFailureResponse.new)
      subject
    end

    it { expect(Hovercat::Models::MessageRetry.count).to be(1) }

    it do
      result_message_retry = Hovercat::Models::MessageRetry.first
      expect(result_message_retry.payload).to eql(message.to_json)
      expect(result_message_retry.header).to eql('{}')
      expect(result_message_retry.routing_key).to eql(message.routing_key)
      expect(result_message_retry.exchange).to eql(Hovercat::CONFIG[:exchange])
      expect(result_message_retry.retry_count).to eql(0)
    end

  end

  context 'All params set and successfully stored to retry' do
    let(:header) { {content_type: 'Application/json'} }
    let(:exchange) { 'test.exchange' }
    before do
      expect(publisher).to receive(:publish).with(payload: message.to_json, header: header, routing_key: message.routing_key, exchange: exchange).and_return(Hovercat::Models::PublishFailureResponse.new)
      subject
    end

    it { expect(Hovercat::Models::MessageRetry.count).to be(1) }

    it do
      result_message_retry = Hovercat::Models::MessageRetry.first
      expect(result_message_retry.payload).to eql(message.to_json)
      expect(result_message_retry.header).to eql('{:content_type=>"Application/json"}')
      expect(result_message_retry.routing_key).to eql(message.routing_key)
      expect(result_message_retry.exchange).to eql(exchange)
      expect(result_message_retry.retry_count).to eql(0)
    end

  end

  context 'All params set and failed to store message retry' do
    let(:header) { {content_type: 'Application/json'} }
    let(:exchange) { 'test.exchange' }
    before do
      expect(publisher).to receive(:publish).with(payload: message.to_json, header: header, routing_key: message.routing_key, exchange: exchange).and_return(false)

    end

    it do
      allow(Hovercat::Models::MessageRetry).to receive(:create!).and_raise(ActiveRecord::RecordNotSaved)
      expect { subject }.to raise_error(Hovercat::Exceptions::UnableToSendMessageError)
    end

  end

end
