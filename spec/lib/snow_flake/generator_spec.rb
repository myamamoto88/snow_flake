require 'spec_helper'

describe SnowFlake::Generator do
  let(:generator) { described_class.new }
  let(:commander) { double('Commander') }

  before { allow_any_instance_of(described_class).to receive(:commander).and_return(commander) }

  describe '#id' do
    subject { generator.id }

    before do
      allow(commander).to receive(:process)
      allow(commander).to receive(:conflate)
      allow(commander).to receive(:wait?).and_return(false)
    end

    context 'id generation is success' do
      it 'update @last_timestamp_ms' do
        before_timestamp_ms = generator.instance_variable_get(:@last_timestamp_ms)
        subject
        after_timestamp_ms = generator.instance_variable_get(:@last_timestamp_ms)

        expect(before_timestamp_ms).to_not eq after_timestamp_ms
      end
    end

    context 'if current time is back' do
      let(:current_timestamp) { Time.parse('2017-03-01 10:00:00') }
      let(:last_timestamp_ms) { Time.parse('2017-04-01 10:00:00').to_f * 1_000 }

      before do
        Timecop.freeze(current_timestamp)
        allow(generator).to receive(:last_timestamp_ms).and_return(last_timestamp_ms)
      end
      after { Timecop.return }

      it { expect { subject }.to raise_error described_class::TimeMoveBackWardError }
    end
  end

  describe '#setup' do
    subject { generator.setup(config) }

    let(:config) { double('Config') }

    before do
      expect(commander).to receive(:setup).with(config)
    end

    it { expect { subject }.to_not raise_error }
  end
end
