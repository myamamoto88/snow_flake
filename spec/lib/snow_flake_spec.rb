require 'spec_helper'

describe SnowFlake do
  describe 'command methods' do
    let(:provider) { double('Provider') }

    before do
      allow_any_instance_of(described_class).to receive(:provider).and_return(provider)
      expect(provider).to receive(:id)
      expect(provider).to receive(:setup)
    end

    it 'pass to provider' do
      described_class.id
      described_class.setup
    end
  end
end
