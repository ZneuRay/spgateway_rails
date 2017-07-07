require 'spec_helper'

describe 'PeriodicalResult' do
	it 'should decoded the returns data currently' do
		
		SpgatewayRails.configure do |config|
			config.merchant_id = '12345678'
			config.hash_key = '12345678901234567890123456789012'
			config.hash_iv = '1234567890123456'
		end
		url_params = 'Status=SUCCESS&MerchantID%5D=12345678'
		encrypted = SpgatewayRails::SpgatewayHelper.encrypt_data(url_params)
		
		period = SpgatewayRails::Periodical::PeriodicalResult.new encrypted
		expect(period.get_result["Status"]).to eq('SUCCESS')
	end
end