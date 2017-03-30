require 'spec_helper'

describe SnowFlake::Component::Sequence do
  describe '#process' do
    let(:sequence) { described_class.new }
    let(:timestamp_ms) { (Time.now.to_f * 1_000).to_i }
    let(:last_timestamp_ms) { timestamp_ms }
    let(:resource) { double('Resource', timestamp_ms: timestamp_ms, last_timestamp_ms: last_timestamp_ms) }

    context 'value is count up' do
      let(:default_value) { 10 }

      before { sequence.instance_variable_set(:@value, default_value) }

      it 'returns value that default value plus 1' do
        sequence.process(resource)
        expect(sequence.value).to eq(default_value + 1)
      end
    end

    context 'timestamp_ms and last_timestamp_ms are defferent' do
      let(:timestamp_ms) { (Time.now.to_f * 1_000).to_i }
      let(:last_timestamp_ms) { timestamp_ms - 100 }

      it 'returns first value' do
        sequence.process(resource)
        expect(sequence.value).to eq 1
      end
    end

    context 'sequence#value is upper limit' do
      before { sequence.instance_variable_set(:@value, sequence.max_bits) }

      it 'returns zero' do
        sequence.process(resource)
        expect(sequence.value).to eq 0
      end
    end
  end
end
