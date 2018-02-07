module SpgatewayRails
	module Merchant
		class MerchantActivateResult < SpgatewayRails::SpgatewayResult

			CHECK_CODE = "CheckCode"
			DATA_FIELDS = %w(CreditInst CreditRed Date MerchantID UseInfo)

			def initialize params
				@check_code = params[CHECK_CODE]

				@check_data = {}
				DATA_FIELDS.each do |field|
					@check_data[field] = params[field] unless params[field].blank?
				end
				@check_string = @check_data.to_query
			end

			def valid?
				check_code = SpgatewayHelper.sha256_encode_merchant_info(@check_string)
				puts check_code
				if @check_code == check_code
					true
				else
					false
				end
			end

		end
	end
end