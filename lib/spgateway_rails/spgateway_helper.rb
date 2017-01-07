require 'openssl'
require 'base64'

module SpgatewayRails
	module SpgatewayHelper

		def self.encrypt_data(data)
			config = SpgatewayRails.config
			encrypt config.hash_key, config.hash_iv, data
		end

		def self.encrypt(key, iv, data)
			cipher = OpenSSL::Cipher::AES256.new(:CBC)
			cipher.encrypt
			cipher.padding = 0
			cipher.key = key
			cipher.iv = iv
			padding_data = add_padding(data)
			encrypted = cipher.update(padding_data) + cipher.final
			encrypted.unpack('H*').first
		end

		def self.add_padding(data, block_size=32)
			pad = block_size - (data.length % block_size)
			data + (pad.chr * pad)
		end

		def self.decrypt_data(encrypted_data)
			config = SpgatewayRails.config
			decrypt config.hash_key, config.hash_iv, encrypted_data
		end

		def self.decrypt(key, iv, encrypted_data)
			encrypted_data = encrypted_data.pack('H*')
			decipher = OpenSSL::Cipher::AES256.new(:CBC)
			decipher.decrypt
			decipher.padding = 0
			decipher.key = key
			decipher.iv = iv
			data = decipher.update(encrypted_data) + decipher.final
			strippadding data
		end

		def self.strippadding(data)
			slast = data[-1].ord
			slastc = slast.chr
			padding_index = /#{slastc}{#{slast}}/ =~ data
			if padding_index != nil
				data[0, padding_index]
			else
				false
			end
		end
	end
end