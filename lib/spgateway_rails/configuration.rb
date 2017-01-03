module SpgatewayRails

	class Configuration
		attr_accessor :merchant_id
		attr_accessor :hash_key
		attr_accessor :hash_iv

		def initialize
			@merchant_id = ''
			@hash_key = ''
			@hash_iv = ''
		end
	end

end