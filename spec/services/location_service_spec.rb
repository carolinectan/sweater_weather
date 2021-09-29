require 'rails_helper'

RSpec.describe LocationService do
  describe 'class methods' do
    describe '.find_lat_long' do
      it 'returns latitude and longitude based on location', :vcr do
        location = LocationService.find_lat_long('denver,co')

        expect(location).to be_a Hash
        expect(location).to have_key(:info)
        expect(location[:info]).to be_a Hash
        expect(location[:info]).to have_key(:statuscode)
        expect(location[:info][:statuscode]).to be_a Numeric
        expect(location[:info]).to have_key(:copyright)
        expect(location[:info][:copyright]).to be_a Hash
        expect(location[:info]).to have_key(:messages)
        expect(location[:info][:messages]).to be_an Array
        expect(location).to have_key(:options)
        expect(location[:options]).to be_a Hash
        expect(location).to have_key(:results)
        expect(location[:results]).to be_an Array
        expect(location[:results][0]).to have_key(:locations)
        expect(location[:results][0][:locations]).to be_an Array
        expect(location[:results][0][:locations][0]).to have_key(:latLng)
        expect(location[:results][0][:locations][0][:latLng]).to be_a Hash
        expect(location[:results][0][:locations][0][:latLng]).to have_key(:lat)
        expect(location[:results][0][:locations][0][:latLng][:lat]).to be_a Numeric
        expect(location[:results][0][:locations][0][:latLng]).to have_key(:lng)
        expect(location[:results][0][:locations][0][:latLng][:lng]).to be_a Numeric
      end
    end

    describe '.get_conn' do
      it 'returns a Faraday object for a location', :vcr do
        conn = LocationService.conn

        expect(conn).to be_a Faraday::Connection
      end
    end
  end
end
