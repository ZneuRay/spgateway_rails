module SpgatewayRails
	module Periodical
		class SpgatewayPeriodical
			POST_DATA_FIELDS = %w( RespondType TimeStamp Version MerOrderNo ProdDesc PeriodAmt PeriodType PeriodPoint PeriodStartType PeriodTimes ReturnURL PeriodMemo PayerEmail EmailModify PaymentInfo OrderInfo NotifyURL BackURL)
			RESPOND_TYPE = "String"
			VERSION = '1.0'
			PERIOD_AMOUNT = 1000
			PERIOD_TYPE = "M"
			PERIOD_START_TYPE = 2
			PERIOD_TIMES = "120"

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
				@post_data["PeriodStartType"] = PERIOD_START_TYPE
				@post_data["PeriodTimes"] = PERIOD_TIMES
				reset_period_point
			end

			# Returns value by name
			def [](name)
				@post_data[name]
			end

			# Sets value by name
			def []=(name, value)
				@post_data[name] = value
			end

			# Setup value by block
			def setup
				yield self
			end

			# Get valid params from post_data
			def get_url_params
				params = {}
				POST_DATA_FIELDS.each do |f|
					params[f] = @post_data[f]
				end
				URI.encode_www_form(params)
			end

			def get_post_data_string
				SpgatewayRails::SpgatewayHelper.encrypt_data get_url_params
			end

			# Returns the value of time
			#
			# @return 14837404323385332
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

			# Setup the day of today with format which related to PeriodType
			def reset_period_point
				@post_data["PeriodPoint"] = get_period_time_of_today
			end

			private

			def get_period_time_of_today
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