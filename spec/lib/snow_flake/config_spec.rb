require 'spec_helper'

describe SnowFlake::Config do
  describe '#setup' do
    subject { described_class.new }

    it 'sets value, and returns value' do
      subject.setup do |c|
        c.machine_id = 100
        c.generation_start_time = Time.parse('2017-03-01 19:00:00')
      end

      expect(subject.machine_id).to eq 100
      expect(subject.generation_start_time).to eq Time.parse('2017-03-01 19:00:00')
    end
  end
end
