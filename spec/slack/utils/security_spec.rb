# frozen_string_literal: true

require 'slack/utils/security'

RSpec.describe Slack::Utils::Security do
  describe '.secure_compare' do
    it 'performs string comparison correctly' do
      expect(described_class.secure_compare('a', 'a')).to be true
      expect(described_class.secure_compare('a', 'b')).to be false
    end

    it 'returns false on bytesize mismatch' do
      expect(described_class.secure_compare('a', "\u{ff41}")).to be false
    end
  end

  describe '.fixed_length_secure_compare' do
    it 'performs string comparison correctly' do
      expect(described_class.fixed_length_secure_compare('a', 'a')).to be true
      expect(described_class.fixed_length_secure_compare('a', 'b')).to be false
    end

    it 'raises ArgumentError on length mismatch' do
      expect do
        described_class.fixed_length_secure_compare('a', 'ab')
      end.to raise_error(ArgumentError, 'inputs must be of equal length')
    end
  end
end
