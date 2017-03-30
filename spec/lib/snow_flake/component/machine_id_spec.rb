require 'spec_helper'

describe SnowFlake::Component::MachineId do
  describe '#const?' do
    subject { described_class.new.const? }

    it { is_expected.to be_truthy }
  end
end
