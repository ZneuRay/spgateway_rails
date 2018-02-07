require 'spec_helper'

describe SpgatewayRails::Merchant::MerchantActivateResult do

  it 'should test check code method for activate result can work correctly' do

    SpgatewayRails.merchant_configure do |config|
      config.hash_iv = '1234567'  
      config.hash_key = 'abcdefg'  
    end

    activate_data = {
      "CheckCode": "77A1EF8F23C94CB63A60A7EDF99AC3E0F4688D96AF6D4B34370D306ABD33D0F6",
      "MerchantID": "ABC1422967",
      "Date": "2015-01-01 00:00:00",
      "UseInfo": "ON",
      "CreditInst": "ON",
      "CreditRed": "ON"
    }
    params = ActionController::Parameters.new activate_data
    
    activate_result = SpgatewayRails::Merchant::MerchantActivateResult.new(params)
    expect(activate_result.valid?).to be_truthy
  end

end