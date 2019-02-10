RSpec.describe Hovercat::Models::PublishSuccessfullyResponse do

  subject! { Hovercat::Models::PublishSuccessfullyResponse.new.process_message(message) }

  context 'message removed' do
    let(:message) { create(:message_retry) }
    it { expect(Hovercat::Models::MessageRetry.all).to be_empty }
  end

end