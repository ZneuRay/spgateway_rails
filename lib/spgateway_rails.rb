require 'action_controller'
require 'action_view'

module SpgatewayRails

	def self.config
		@@config ||= Configuration.new
	end

	def self.configure
		yield config
	end

	def self.merchant_config
		@@merchant_config ||= MerchantConfiguration.new
	end

	def self.merchant_configure
		yield merchant_config
	end

	def self.get_error_message code
		# @@error_codes ||= ErrorCodes.new
		ErrorCodes.error_codes[code.to_sym]
	end
end

require 'spgateway_rails/version'
require 'spgateway_rails/configuration'
require 'spgateway_rails/merchant_configuration'
require 'spgateway_rails/error_codes'
require 'spgateway_rails/controller_helper'
require 'spgateway_rails/view_helper'
require 'spgateway_rails/spgateway_helper'
require 'spgateway_rails/spgateway_params'
require 'spgateway_rails/spgateway_result'
require 'spgateway_rails/periodical/spgateway_periodical'
require 'spgateway_rails/periodical/periodical_result'
require 'spgateway_rails/mpg/spgateway_mpg'
require 'spgateway_rails/mpg/mpg_result'
require 'spgateway_rails/merchant/spgateway_merchant'
require 'spgateway_rails/merchant/merchant_activate_result'
require 'spgateway_rails/transaction/spgateway_transaction'
require 'spgateway_rails/transaction/transaction_result'

ActionController::Base.send :include, SpgatewayRails::ControllerHelper
ActionView::Base.send :include, SpgatewayRails::ViewHelper