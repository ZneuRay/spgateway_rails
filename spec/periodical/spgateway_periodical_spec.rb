require 'spec_helper'

describe SpgatewayRails::Periodical::SpgatewayPeriodical do
	subject {SpgatewayRails::Periodical::SpgatewayPeriodical.new}
	it 'should create periodical object' do
		
		expect(subject).to be_instance_of(SpgatewayRails::Periodical::SpgatewayPeriodical)
	end

	it 'should return data params' do
		subject.get_url_params
	end
end