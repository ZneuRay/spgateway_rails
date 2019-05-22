module SpgatewayRails
	module Transaction
    class SpgatewayTransaction < SpgatewayRails::SpgatewayParams
      POST_DATA_FIELDS = %w(Amt MerchantID MerchantOrderNo)
      SERVICE_TYPE = 'API'
      SERVICE_ACTION = 'QueryTradeInfo'
      RESPOND_TYPE = 'JSON'
      VERSION = '1.1'
      
      def initialize
				super
        @config = SpgatewayRails.config
        @post_data["MerchantID"] = @config.merchant_id
        @post_data["Version"] = VERSION
        @post_data["RespondType"] = RESPOND_TYPE
        @post_data["TimeStamp"] = Time.now.to_i.to_s
      end
      
      def get_encrypt_string
        SpgatewayRails::SpgatewayHelper.sha256_encode_transaction_info get_url_params
      end

      def send_request service_url=SpgatewayRails::Transaction::SpgatewayTransaction.service_url
        @post_data["CheckValue"] = get_encrypt_string
        uri = URI(service_url)

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        req = Net::HTTP::Post.new(uri)
        req.set_form_data(@post_data)

        response = http.request(req)
        JSON.parse(response.body)
      end
    end
  end
end