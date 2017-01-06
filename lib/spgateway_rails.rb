require 'action_controller'

module SpgatewayRails

	def self.config
		@@config ||= Configuration.new
	end

	def self.configure
		yield config
	end

	def self.get_error_message code
		# @@error_codes ||= ErrorCodes.new
		ErrorCodes.error_codes[code.to_sym]
	end
end

require 'spgateway_rails/version'
require 'spgateway_rails/configuration'
require 'spgateway_rails/error_codes'
require 'spgateway_rails/controller_helper'
require 'spgateway_rails/view_helper'
require 'spgateway_rails/spgateway_helper'
require 'spgateway_rails/periodical/spgateway_periodical'
require 'spgateway_rails/periodical/spgateway_return'
require 'spgateway_rails/periodical/spgateway_notification'

ActionController::Base.send :include, SpgatewayRails::ControllerHelper
ActionController::Base.send :include, SpgatewayRails::ViewHelper