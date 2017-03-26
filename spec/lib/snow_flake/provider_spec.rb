require 'spec_helper'

describe SnowFlake::Provider do
  let(:provider) { described_class.new }

  describe '#id' do
    subject { provider.id }

    let(:generation_start_time) { Time.parse('2017-01-01 10:00:00') }
    let(:current_timestamp) { Time.parse('2017-03-01 12:00:00') }
    let(:timestamp) { (current_timestamp.to_f * 1_000).to_i - (generation_start_time.to_f * 1_000).to_i }
    let(:machine_id) { 1 }
    let(:sequence) { 1 }
    let(:id) { (timestamp << (10 + 12)) + (machine_id << 12) + sequence }

    before { Timecop.freeze(current_timestamp) }
    after { Timecop.return }

    context 'id generation is success' do
      before do
        provider.setup do |config|
          config.generation_start_time = Time.parse('2017-01-01 10:00:00')
          config.machine_id = 1
        end
      end

      it { is_expected.to eq id }
    end

    context 'if generate id before setup' do
      it { expect { subject }.to raise_error described_class::NoSetup }
    end

    context 'multiple thread' do
      subject do
        ids_one = []
        ids_two = []

        thread_one = Thread.new(amount_of_id / 2, provider) { |n, p| ids_one = Array.new(n) { p.id } }
        thread_two = Thread.new(amount_of_id / 2, provider) { |n, p| ids_two = Array.new(n) { p.id } }

        timeout = 3
        thread_one.join(timeout)
        thread_two.join(timeout)

        (ids_one + ids_two).uniq
      end

      let(:amount_of_id) { 1000 }

      before do
        provider.setup do |config|
          config.generation_start_time = Time.parse('2017-01-01 10:00:00')
          config.machine_id = 1
        end
      end

      it { expect(subject.size).to eq amount_of_id }
    end
  end

  describe '#setup' do
    context 'setup is success' do
      subject do
        provider.setup do |config|
          config.generation_start_time = Time.parse('2017-01-01 10:00:00')
          config.machine_id = 1
        end
      end

      it { expect { subject }.to_not raise_error }
    end

    context 'if machine_id undefined to setup block' do
      subject do
        provider.setup do |config|
          config.generation_start_time = Time.parse('2017-01-01 10:00:00')
        end
      end

      it { expect { subject }.to raise_error }
    end

    context 'if generation_start_time undefined to setup block' do
      subject do
        provider.setup do |config|
          config.machine_id = 1
        end
      end

      it { expect { subject }.to raise_error }
    end
  end
end
