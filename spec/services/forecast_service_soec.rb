require 'rails_helper'

RSpec.describe ForecastService do
  describe 'class methods' do
    describe '.get_forecast' do
      it 'returns forecast based on location', :vcr do
        forecast = ForecastService.get_forecast('denver,co')

        expect(forecast).to be_a Hash
        expect(forecast).to have_key(:lat)
        expect(forecast[:lat]).to be_a Numeric
        expect(forecast).to have_key(:lon)
        expect(forecast[:lon]).to be_a Numeric
        expect(forecast).to have_key(:timezone)
        expect(forecast[:timezone]).to be_a String
        expect(forecast).to have_key(:timezone_offset)
        expect(forecast[:timezone_offset]).to be_a Numeric
        expect(forecast).to have_key(:current)
        expect(forecast[:current]).to be_a Hash
        expect(forecast).to have_key(:hourly)
        expect(forecast[:hourly]).to be_a Hash
        expect(forecast).to have_key(:daily)
        expect(forecast[:daily]).to be_a Hash
        end
      end

    describe '.get_conn' do
      it 'returns a Faraday object for a forecast', :vcr do
        conn = ForecastService.conn

        expect(conn).to be_a Faraday::Connection
      end
    end
  end
end
