module SpgatewayRails
	module Mpg
		class SpgatewayMpg < SpgatewayRails::SpgatewayParams
			POST_DATA_FIELDS = %w( MerchantID RespondType TimeStamp Version LangType MerchantOrderNo Amt ItemDesc TradeLimit ExpireDate ReturnURL NotifyURL CustomerURL ClientBackURL Email EmailModify LoginType OrderComment CREDIT InstFlag CreditRed UNIONPAY WEBATM VACC CVS BARCODE)
			SERVICE_TYPE = 'mpg_gateway'
			RESPOND_TYPE = "String"
			VERSION = '1.4'
			MPG_AMOUNT = 1000
			MPG_LOGIN_TYPE = 0

			def initialize
				@config = SpgatewayRails.config
				@post_data = {}
				@post_data["MerchantID"] = @config.merchant_id
				@post_data["RespondType"] = RESPOND_TYPE
				@post_data["TimeStamp"] = Time.now.to_i
				@post_data["Version"] = VERSION
				@post_data["MerchantOrderNo"] = generate_order_no
				@post_data["Amt"] = MPG_AMOUNT
				@post_data["ItemDesc"] = "Please input the item description."
				@post_data["Email"] = ""
				@post_data["LoginType"] = MPG_LOGIN_TYPE
			end

			def get_trade_info
				@trade_info ||= get_post_data_string
			end

			def get_trade_sha
				@trade_sha ||= SpgatewayRails::SpgatewayHelper.sha256_encode_trade_info(get_trade_info)
			end

			private
		end
	end
end