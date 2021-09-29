require 'rails_helper'

RSpec.describe Location do
  it 'can initialize from location params' do
    location_params = {:lat=>39.738453, :lng=>-104.984853}

    location = Location.new(location_params)

    expect(location).to be_an_instance_of Location
    expect(location.latitude).to eq(39.738453)
    expect(location.longitude).to eq(-104.984853)
  end
end
