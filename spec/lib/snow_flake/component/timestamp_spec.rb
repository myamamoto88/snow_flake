require 'spec_helper'

describe SnowFlake::Component::Timestamp do
  let(:timestamp) { described_class.new }

  describe '#setup' do
    let(:config) { double('Config', generation_start_time: generation_start_time) }

    context 'config.generation_start_time is a Time' do
      let(:generation_start_time) { Time.now }
      let(:generation_start_time_ms) { generation_start_time.to_i * 1_000 }

      it 'sets generation_start_time_ms value' do
        timestamp.setup(config)
        expect(timestamp.send(:generation_start_time_ms)).to eq generation_start_time_ms
      end
    end

    context 'config.generation_start_time is not a Time' do
      let(:generation_start_time) { nil }

      it { expect { timestamp.setup(config) }.to raise_error described_class::NilGenrationStartTimeOfConfig }
    end
  end

  describe '#process' do
    let(:timestamp_ms) { Time.parse('2017-03-01 10:00:00').to_i * 1_000 }
    let(:generation_start_time) { Time.parse('2017-03-01 00:00:00') }
    let(:generation_start_time_ms) { generation_start_time.to_i * 1_000 }
    let(:config) { double('Config', generation_start_time: generation_start_time) }
    let(:resource) { double('Resource', timestamp_ms: timestamp_ms) }
    let(:value) { timestamp_ms - generation_start_time_ms }

    before { timestamp.setup(config) }

    it 'updates value' do
      expect(timestamp.value).to eq 0
      timestamp.process(resource)
      expect(timestamp.value).to eq value
    end
  end
end
