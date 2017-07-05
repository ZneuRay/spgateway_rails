module SpgatewayRails
  class SpgatewayParams

    attr_accessor :post_data

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

    # Returns the value of time
    #
    # @return 14837404323385332
    def generate_order_no
      Time.now.to_f.to_s.tr('.', '')
    end

    # Get valid params from post_data
    def get_url_params
      params = {}
      self.class::POST_DATA_FIELDS.each do |f|
        params[f] = @post_data[f]
      end
      URI.encode_www_form(params)
    end

    def get_post_data_string
      SpgatewayRails::SpgatewayHelper.encrypt_data get_url_params
    end
    
    def self.service_url
      case SpgatewayRails.config.mode
      when :production
        "https://core.spgateway.com/MPG/#{self::SERVICE_TYPE}"
      when :development
        "https://ccore.spgateway.com/MPG/#{self::SERVICE_TYPE}"
      else
        "https://ccore.spgateway.com/MPG/#{self::SERVICE_TYPE}"
      end
    end

  end
end