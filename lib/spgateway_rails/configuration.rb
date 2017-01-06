module SpgatewayRails

	class Configuration
		attr_accessor :merchant_id
		attr_accessor :hash_key
		attr_accessor :hash_iv
		attr_accessor :mode

		def initialize
			@merchant_id = ''
			@hash_key = ''
			@hash_iv = ''
			@mode = :development
		end
	end

end