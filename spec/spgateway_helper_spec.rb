require 'spec_helper'

describe SpgatewayRails::SpgatewayHelper do
	it 'should encrypt data' do
		encrypted = subject.encrypt("12345678901234567890123456789012", "1234567890123456", "abcdefghijklmnop")
		expect(encrypted).to eq("b91d3ece42c203729b38ae004e96efb9b64c41eeb074cad7ebafa3973181d233")
	end

	it 'should decrypt data' do
		decrypted = subject.decrypt("12345678901234567890123456789012", "1234567890123456", "b91d3ece42c203729b38ae004e96efb9b64c41eeb074cad7ebafa3973181d233")
		expect(decrypted).to eq("abcdefghijklmnop")
	end

	it 'should encode trade info by SHA256' do
		encoded = subject.sha256_encode("12345678901234567890123456789012", "1234567890123456", "ff91c8aa01379e4de621a44e5f11f72e4d25bdb1a18242db6cef9ef07d80b0165e476fd1d9acaa53170272c82d122961e1a0700a7427cfa1cf90db7f6d6593bbc93102a4d4b9b66d9974c13c31a7ab4bba1d4e0790f0cbbbd7ad64c6d3c8012a601ceaa808bff70f94a8efa5a4f984b9d41304ffd879612177c622f75f4214fa")
		expect(encoded).to eq("EA0A6CC37F40C1EA5692E7CBB8AE097653DF3E91365E6A9CD7E91312413C7BB8")
	end
end