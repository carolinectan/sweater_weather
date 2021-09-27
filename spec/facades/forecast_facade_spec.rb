require 'rails_helper'

RSpec.describe ForecastFacade do
  describe 'class methods' do
    describe '.get_forecast' do
      it 'returns a weather object', :vcr do
        location_query = 'denver,co'
        location = LocationFacade.find_lat_long(location_query)
        forecast = ForecastFacade.get_forecast(location)

        expect(forecast).to_not be_an Array
        expect(forecast).to be_a Weather

        expect(forecast.current).to be_a CurrentForecast
        expect(forecast.current.conditions).to be_a String
        expect(forecast.current.datetime).to be_a String
        expect(forecast.current.feels_like).to be_a Numeric
        expect(forecast.current.humidity).to be_a Numeric
        expect(forecast.current.icon).to be_a String
        expect(forecast.current.sunrise).to be_a String
        expect(forecast.current.sunset).to be_a String
        expect(forecast.current.temperature).to be_a Numeric
        expect(forecast.current.uvi).to be_a Numeric
        expect(forecast.current.visibility).to be_a Numeric

        expect(forecast.daily).to be_an Array
        expect(forecast.daily.length).to eq(5)
        forecast.daily.each do |daily|
          expect(daily).to be_a DailyForecast
          expect(daily.conditions).to be_a String
          expect(daily.date).to be_a String
          expect(daily.icon).to be_a String
          expect(daily.max_temp).to be_a Numeric
          expect(daily.min_temp).to be_a Numeric
          expect(daily.sunrise).to be_a String
          expect(daily.sunset).to be_a String
        end

        expect(forecast.hourly).to be_an Array
        expect(forecast.hourly.length).to eq(8)
        forecast.hourly.each do |hourly|
          expect(hourly).to be_a HourlyForecast
          expect(hourly.conditions).to be_a String
          expect(hourly.icon).to be_a String
          expect(hourly.temperature).to be_a Numeric
          expect(hourly.time).to be_a String
        end
      end
    end
  end
end
