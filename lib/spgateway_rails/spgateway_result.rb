module SpgatewayRails
  class SpgatewayResult

    def initialize return_data
      @raw_params = decrypt_data return_data
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

    def get_result
      @result_data
    end

    def status
      if @result_data["status"]
        @result_data["status"]
      else
        nil
      end
    end

    def success?
      return true if status && status == 'SUCCESS'
      false
    end
    

    private

     def decrypt_data data
      SpgatewayRails::SpgatewayHelper.decrypt_data data
    end

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