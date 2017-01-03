require 'spec_helper'

describe SpgatewayRails::Configuration do
	it 'should be returned by SpgatewayRails.config' do
		expect(SpgatewayRails.config).to be_instance_of(SpgatewayRails::Configuration)
	end

	it 'should be yielded by SpgatewayRails.configure' do
		SpgatewayRails.configure do |c|
			expect(c).to be_instance_of(SpgatewayRails::Configuration)
			expect(c).to be(SpgatewayRails.config)
		end
	end
end