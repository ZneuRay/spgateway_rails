require 'openssl'
require 'base64'

module SpgatewayRails
	module SpgatewayHelper		
		def encrypt key, iv, data
			cipher = OpenSSL::Cipher::AES256.new(:CBC)
			cipher.encrypt
			cipher.padding = 0
			cipher.key = key
			cipher.iv = iv
			padding_data = add_padding(data)
			encrypted = cipher.update(padding_data) + cipher.final
		end

		def add_padding data, block_size=32
			pad = block_size - (data.length % block_size)
			data + (pad.chr * pad)
		end

		def decrypt key, iv, encrypted_data
			decipher = OpenSSL::Cipher::AES256.new(:CBC)
			decipher.decrypt
			decipher.key = key
			decipher.iv = iv
			data = decipher.update(encrypted_data) + decipher.final

		end
	end
end