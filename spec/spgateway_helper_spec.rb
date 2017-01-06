require 'spec_helper'

describe SpgatewayRails::SpgatewayHelper do
	it 'should encrypt data' do
		encrypted = subject.encrypt("12345678901234567890123456789012", "1234567890123456", "abcdefghijklmnop")
		expect(encrypted).to eq("b91d3ece42c203729b38ae004e96efb9b64c41eeb074cad7ebafa3973181d233")
	end

	it 'should decrypt data' do
		decrypted = subject.decrypt("12345678901234567890123456789012", "1234567890123456", ["b91d3ece42c203729b38ae004e96efb9b64c41eeb074cad7ebafa3973181d233"])
		expect(decrypted).to eq("abcdefghijklmnop")
	end
end