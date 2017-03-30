require 'spec_helper'

describe SnowFlake::Component::Base do
  after { Object.send(:remove_const, :TestComponent) }

  describe '#setup' do
    context 'no implement method' do
      let(:config) { double('Config') }

      before do
        class TestComponent < described_class
        end
      end

      it { expect { TestComponent.new.setup(config) }.to raise_error NotImplementedError }
    end
  end

  describe '#bits' do
    context 'no implement method' do
      before do
        class TestComponent < described_class
        end
      end

      it { expect { TestComponent.new.bits }.to raise_error NotImplementedError }
    end
  end

  describe '#value' do
    subject { TestComponent.new.value }

    let(:default_value) { 0 }

    before do
      class TestComponent < described_class
        def bits
          10
        end
      end
    end

    it { is_expected.to eq default_value }
  end

  describe '#max_bits' do
    subject { TestComponent.new.max_bits }

    before do
      class TestComponent < described_class
        def bits
          4
        end
      end
    end

    it { is_expected.to eq 0b1111 }
  end

  describe '#process' do
    subject { TestComponent.new.process(resource) }

    let(:resource) { double('Resource') }

    before do
      class TestComponent < described_class
        def bits
          1
        end

        def _process(_resource); end
      end

      allow_any_instance_of(described_class).to receive(:value).and_return(value)
    end

    context 'value is out of range' do
      let(:value) { -1 }

      it { expect { subject }.to raise_error described_class::InvalidValueError }
    end

    context 'value is not out of range' do
      let(:value) { 1 }

      it { expect { subject }.not_to raise_error }
    end
  end

  describe '#wait?' do
    subject { TestComponent.new.wait? }

    before do
      class TestComponent < described_class
      end
    end

    it { is_expected.to be_falsy }
  end
end
