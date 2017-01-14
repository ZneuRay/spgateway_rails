module SpgatewayRails
	module ViewHelper

		def spgateway_periodical
			@spgateway_periodical ||= Periodical::SpgatewayPeriodical.new
		end

		def spgateway_periodical_form(btn_value="Go", btn_class="")
			# form_tag Periodical::SpgatewayPeriodical.service_url do
			# 	hidden_field_tag 'MerchantID_', SpgatewayRails.config.merchant_id
			# 	hidden_field_tag 'PostData_', spgateway_periodical.get_post_data_string
			# 	submit_tag 'submit'
			# end
			service_url = Periodical::SpgatewayPeriodical.service_url
			merchant_id = SpgatewayRails.config.merchant_id
			post_data = spgateway_periodical.get_post_data_string
			form = '<form name="spgateway-periodical-form" id="spgateway-periodical-form" action="' << service_url << '" method="post">'
			form << '<input type="hidden" name="MerchantID_" value="' << merchant_id << '">'
			form << '<input type="hidden" name="PostData_" value="' << post_data << '">'
			form << '<input type="submit" name="spgateway-periodical-submit" value="' << btn_value << '" class="' << btn_class << '">'
			form << '</form>'
			form.html_safe
		end
	end
end