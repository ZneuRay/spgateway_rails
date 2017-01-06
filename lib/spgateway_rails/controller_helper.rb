module SpgatewayRails
	module ControllerHelper

		def spgateway_periodical
			@spgateway_periodical ||= Periodical::SpgatewayPeriodical.new
		end
	end
end