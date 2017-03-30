require 'spec_helper'

describe SnowFlake::Component::Constable do
  after { Object.send(:remove_const, :TestComponent) }

  describe '#const?' do
    subject { TestComponent.new.const? }

    before do
      class TestComponent
        include ::SnowFlake::Component::Constable
      end
    end

    it { is_expected.to be_truthy }
  end
end
