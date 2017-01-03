require 'action_controller'

module SpgatewayRails

	def self.config
		@@config ||= Configuration.new
	end

	def self.configure
		yield config
	end
end

require "spgateway_rails/version"
require "spgateway_rails/configuration"
require "spgateway_rails/spgateway_helper"

ActionController::Base.send :include, SpgatewayRails::SpgatewayHelper