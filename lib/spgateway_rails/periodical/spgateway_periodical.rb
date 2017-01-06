module SpgatewayRails
	module Periodical
		class SpgatewayPeriodical
			POST_DATA_FIELDS = %w( RespondType TimeStamp Version MerOrderNo ProdDesc PeriodAmt PeriodType PeriodPoint PeriodStartType PeriodTimes ReturnURL PeriodMemo PayerEmail EmailModify PaymentInfo OrderInfo NotifyURL BackURL)
			RESPOND_TYPE = "String"
			VERSION = '1.0'
			PERIOD_AMOUNT = 1000
			PERIOD_TYPE = "M"
			PERIOD_START_TYPE = 3
			PERIOD_TIMES = "120"
			

			# POST_DATA_FIELDS.each do |f|
			# 	mattr_accessor f.underscore.to_sym
			# end

			attr_accessor :post_data

			def initialize
				@post_data = {}
				@post_data["RespondType"] = RESPOND_TYPE
				@post_data["TimeStamp"] = Time.now.to_i
				@post_data["Version"] = VERSION
				@post_data["MerOrderNo"] = generate_order_no
				@post_data["ProdDesc"] = "Please input the product description."
				@post_data["PeriodAmt"] = PERIOD_AMOUNT
				@post_data["PeriodType"] = PERIOD_TYPE
				@post_data["PeriodPoint"] = get_period_point_of_today
				@post_data["PeriodStartType"] = PERIOD_START_TYPE
				@post_data["PeriodTimes"] = PERIOD_TIMES
			end

			# Returns value by name
			def [](name)
				@post_data[name]
			end

			# Sets value by name
			def []=(name, value)
				@post_data[name] = value
			end

			def get_url_params
				params = {}
				POST_DATA_FIELDS.each do |f|
					params[f] = @post_data[f]
				end
				URI.encode_www_form(params)
			end

			def get_encrypted_string
				SpgatewayRails::SpgatewayHelper.encrypt_data get_url_params
			end

			def generate_order_no
				Time.now.to_f.to_s.tr('.', '')
			end

			def self.service_url
				case SpgatewayRails.config.mode
				when :production
					'https://core.spgateway.com/MPG/period'
				when :development
					'https://ccore.spgateway.com/MPG/period'
				else
					'https://ccore.spgateway.com/MPG/period'
				end
			end

			def get_period_point_of_today
				today = Date.today
				case @post_data["PeriodType"]
				when "Y"
					today.strftime('%m%d')
				when "M"
					today.strftime('%d')
				when "W"
					today.strftime('%u')
				else
					@post_data["PeriodType"] = PERIOD_TYPE
					today.strftime('%d')
				end
			end
		end
	end
end