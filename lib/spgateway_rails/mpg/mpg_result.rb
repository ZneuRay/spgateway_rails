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

			private

			def parse_raw_params
				begin
					hash_params = URI::decode_www_form(@raw_params).to_h
					return_params = {}
					hash_params.each do |key, value|
						find_index = key.index('[')
						if find_index.nil?
							return_params[key] = value
						else
							parent_key = key[0...find_index]
							child_key = key[(find_index + 1)...-1]
							return_params[parent_key] ||= {}
							return_params[parent_key][child_key] = value
						end
					end
					return_params
				rescue
					nil
				end
			end

		end
	end
end