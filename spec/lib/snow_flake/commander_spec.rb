require 'spec_helper'

describe SnowFlake::Commander do
  let(:timestamp_ms) { (Time.now.to_f * 1_000).to_i }

  before { allow_any_instance_of(described_class).to receive(:components).and_return(components) }

  describe '#setup' do
    subject { described_class.new.setup(config) }

    let(:components) { Array.new(2) { |n| double("Component #{n}") } }
    let(:config) do
      double(
        'Config',
        machine_id: 5,
        generation_start_time_ms: (Time.parse('2017-01-01 19:00:00').to_f * 1_000).to_i
      )
    end

    it 'sends setup message to Component instances' do
      components.each do |component|
        expect(component).to receive(:setup).with(config)
      end

      subject
    end
  end

  describe '#process' do
    subject { described_class.new.process({}) }

    let(:components) do
      [
        non_constable_components,
        double('Component 3', bits: 3, value: 3, 'const?': true)
      ].flatten
    end
    let(:non_constable_components) do
      [
        double('Component 1', bits: 1, value: 1, 'const?': false),
        double('Component 2', bits: 2, value: 2, 'const?': false)
      ]
    end

    it 'sends process message to Component instances' do
      non_constable_components.each do |component|
        expect(component).to receive(:process)
      end

      subject
    end
  end

  describe '#conflate' do
    subject { described_class.new.conflate }

    let(:components) do
      [
        double('Component 1', bits: 1, value: 1),
        double('Component 2', bits: 2, value: 2),
        double('Component 3', bits: 3, value: 3)
      ]
    end
    let(:id) { (1 << (2 + 3)) + (2 << 3) + 3 }

    it { is_expected.to eq id }
  end
end
