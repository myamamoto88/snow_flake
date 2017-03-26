require 'spec_helper'

describe SnowFlake do
  describe '.id' do
    subject do
      SnowFlake.setup do |config|
        config.generation_start_time = generation_start_time
        config.machine_id = machine_id
      end

      SnowFlake.id
    end

    let(:generation_start_time) { Time.parse('2017-01-01 10:00:00') }
    let(:current_timestamp) { Time.parse('2017-03-01 12:00:00') }
    let(:timestamp) { (current_timestamp.to_f * 1_000).to_i - (generation_start_time.to_f * 1_000).to_i }
    let(:machine_id) { 1 }
    let(:sequence) { 0 }
    let(:id) { (timestamp << (10 + 12)) + (machine_id << 12) + sequence }

    before { Timecop.freeze(current_timestamp) }
    after { Timecop.return }

    it { is_expected.to eq id }
  end
end
