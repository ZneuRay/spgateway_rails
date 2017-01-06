require 'spec_helper'

describe SpgatewayRails::ControllerHelper do
	subject {ActionController::Base.new}
	it 'should be returned by SpgatewayPeriodical' do
		expect(subject.spgateway_periodical).to be_instance_of(SpgatewayRails::Periodical::SpgatewayPeriodical)
	end

	it 'should be mixed into ActionController::Base' do
		expect(ActionController::Base.included_modules).to include(SpgatewayRails::ControllerHelper)
	end
end