RSpec.describe Hovercat::Jobs::RetryMessagesSenderJob do

  subject { Hovercat::Jobs::RetryMessagesSenderJob.new.perform(publisher) }
  before { ActiveJob::Base.queue_adapter = :test }
  let(:perform_job) do
    subject
    expect(Hovercat::Jobs::RetryMessagesSenderJob).to have_been_enqueued
  end

  context 'publisher not passed' do
    let(:publisher) { nil }
    before { allow_any_instance_of(Hovercat::Senders::RetryMessagesSender).to receive(:send) }
    it { perform_job }
  end

  context 'without errors' do
    let(:publisher) { Hovercat::Publishers::Publisher.new }
    before { allow_any_instance_of(Hovercat::Senders::RetryMessagesSender).to receive(:send) }
    it { perform_job }
  end

  context 'with errors' do
    let(:publisher) { Hovercat::Publishers::Publisher.new }
    before { allow_any_instance_of(Hovercat::Senders::RetryMessagesSender).to receive(:send).and_raise(StandardError.new) }
    it { perform_job }
  end

end
