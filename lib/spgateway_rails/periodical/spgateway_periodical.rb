module SpgatewayRails
	module Periodical
		class SpgatewayPeriodical < SpgatewayRails::SpgatewayParams
			POST_DATA_FIELDS = %w( RespondType TimeStamp Version MerOrderNo ProdDesc PeriodAmt PeriodType PeriodPoint PeriodStartType PeriodTimes ReturnURL PeriodMemo PayerEmail EmailModify PaymentInfo OrderInfo NotifyURL BackURL)
			SERVICE_TYPE = 'period'
			RESPOND_TYPE = "String"
			VERSION = '1.0'
			PERIOD_AMOUNT = 1000
			PERIOD_TYPE = "M"
			PERIOD_START_TYPE = 2
			PERIOD_TIMES = "60"

			def initialize
				super
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
					# Because spgateway will skip the month if the day of month doesn't exist
					day_of_month = today.strftime('%d').to_i
					day_of_month = 28 if day_of_month > 28
					'%02d' % day_of_month
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