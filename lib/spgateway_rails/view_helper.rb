module SpgatewayRails
	module ViewHelper

		def spgateway_periodical
			@spgateway_periodical ||= Periodical::SpgatewayPeriodical.new
		end

		def spgateway_periodical_form(btn_value="Go", btn_class="")
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

		def spgateway_mpg
			@spgateway_mpg ||= Mpg::SpgatewayMpg.new
		end

		def spgateway_mpg_form(btn_value="Go", btn_class="")
			service_url = Mpg::SpgatewayMpg.service_url
			merchant_id = SpgatewayRails.config.merchant_id
			trade_info = spgateway_mpg.get_trade_info
			trade_sha = spgateway_mpg.get_trade_sha
			form = '<form name="spgateway-mpg-form" id="spgateway-mpg-form" action="' << service_url << '" method="post">'
			form << '<input type="hidden" name="MerchantID" value="' << merchant_id << '">'
			form << '<input type="hidden" name="TradeInfo" value="' << trade_info << '">'
			form << '<input type="hidden" name="TradeSha" value="' << trade_sha << '">'
			form << '<input type="hidden" name="Version" value="' << Mpg::SpgatewayMpg::VERSION << '">'
			form << '<input type="submit" name="spgateway-mpg-submit" value="' << btn_value << '" class="' << btn_class << '">'
			form << '</form>'
			form.html_safe
		end
	end
end