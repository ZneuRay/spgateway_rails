require 'spec_helper'

describe SpgatewayRails::ErrorCodes do
	it 'should return error message' do
		expect(SpgatewayRails.get_error_message("PER10001")).to eq("商店資料取得失敗")
	end
end