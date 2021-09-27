require 'rails_helper'

RSpec.describe LocationFacade do
  describe 'class methods' do
    describe '.find_lat_long' do
      it 'returns a location object', :vcr do
        location_query = 'denver,co'

        location = LocationFacade.find_lat_long(location_query)

        expect(location).to_not be_an Array
        expect(location).to be_a Location
      end
    end
  end
end
