module SpgatewayRails
	module Mpg
		class MpgResult < SpgatewayRails::SpgatewayResult

			def initialize return_data
        @raw_data = return_data
				@raw_params = decrypt_data @raw_data["TradeInfo"]
        
				begin
					@result_data = JSON.parse(@raw_params)
					@respond_type = :json
				rescue
					@result_data = parse_raw_params
					@respond_type = :string
				end
			end

			def get_raw_result
				@raw_params
			end

      def get_raw_data
        @raw_data
      end

			def get_result
				@result_data
			end

		end
	end
end