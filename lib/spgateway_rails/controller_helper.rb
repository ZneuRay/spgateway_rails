module SpgatewayRails
	module ControllerHelper

		def spgateway_periodical
			@spgateway_periodical ||= Periodical::SpgatewayPeriodical.new
		end

		def spgateway_periodical_result raw_params
			Periodical::PeriodicalResult.new raw_params
		end

		def spgateway_mpg
			@spgateway_mpg ||= Mpg::SpgatewayMpg.new
		end

		def spgateway_mpg_result raw_params
			
		end
	end
end