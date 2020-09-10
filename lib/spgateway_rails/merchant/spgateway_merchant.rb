require 'net/https'

module SpgatewayRails
	module Merchant
		class SpgatewayMerchant < SpgatewayRails::SpgatewayParams

      SERVICE_TYPE = 'API'
			SERVICE_ACTION = 'AddMerchant'

      def get_encrypt_string
        encode_param = URI.encode_www_form(@post_data)
        SpgatewayRails::SpgatewayHelper.encrypt_merchant_data encode_param
      end

      def get_post_data
        post_data = {
          PartnerID_: SpgatewayRails.merchant_config.partner_id,
          PostData_: get_encrypt_string
        }
      end

      # Modify merchant
      def send_modify_request
        send_request "#{SpgatewayRails::Merchant::SpgatewayMerchant.service_url}/modify"
      end

      def send_request service_url=SpgatewayRails::Merchant::SpgatewayMerchant.service_url
        uri = URI(service_url)

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        req = Net::HTTP::Post.new(uri)
        req.set_form_data(get_post_data)

        response = http.request(req)
        JSON.parse(response.body)
      end
    end
  end
end