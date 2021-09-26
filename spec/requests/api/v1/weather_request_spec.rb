require 'rails_helper'

describe 'Weather API' do
  it 'sends the forcast for a given city and state', :vcr do
    location = { location: 'denver,co' }
    headers = { 'CONTENT_TYPE': 'application/json', 'Accept': 'application/json' }

    get '/api/v1/forecast', headers: headers, params: location

    expect(response).to be_successful

    forecast = JSON.parse(response.body, symbolize_names: true)

    expect(forecast).to be_a Hash
    expect(forecast[:data]).to have_key(:id)
    expect(forecast[:data][:id]).to eq(null)
    expect(forecast[:data]).to have_key(:type)
    expect(forecast[:data][:type]).to eq(forecast)
    expect(forecast[:data]).to have_key(:attributes)
    expect(forecast[:data][:attributes].length).to eq(3)

    # holds current weather data
    expect(forecast[:data][:attributes]).to have_key(:current_forecast)
    expect(forecast[:data][:attributes][:current_forecast]).to have_key(:datetime)
    expect(forecast[:data][:attributes][:current_forecast][:datetime]).to be_a String
    expect(forecast[:data][:attributes][:current_forecast]).to have_key(:sunrise)
    expect(forecast[:data][:attributes][:current_forecast][:sunrise]).to be_a String
    expect(forecast[:data][:attributes][:current_forecast]).to have_key(:sunset)
    expect(forecast[:data][:attributes][:current_forecast][:sunset]).to be_a String
    expect(forecast[:data][:attributes][:current_forecast]).to have_key(:temperature)
    expect(forecast[:data][:attributes][:current_forecast][:temperature]).to be_a Float
    expect(forecast[:data][:attributes][:current_forecast]).to have_key(:feels_like)
    expect(forecast[:data][:attributes][:current_forecast][:feels_like]).to be_a Float
    expect(forecast[:data][:attributes][:current_forecast]).to have_key(:humidity)
    expect(forecast[:data][:attributes][:current_forecast][:humidity]).to be_a Float # or Int as given by OpenWeather
    expect(forecast[:data][:attributes][:current_forecast]).to have_key(:uvi)
    expect(forecast[:data][:attributes][:current_forecast][:uvi]).to be_a Float # or Int as given by OpenWeather
    expect(forecast[:data][:attributes][:current_forecast]).to have_key(:visibility)
    expect(forecast[:data][:attributes][:current_forecast][:visibility]).to be_a Float # or Int as given by OpenWeather
    expect(forecast[:data][:attributes][:current_forecast]).to have_key(:conditions)
    expect(forecast[:data][:attributes][:current_forecast]).to be_a String # ?
    expect(forecast[:data][:attributes][:current_forecast]).to have_key(:icon)
    expect(forecast[:data][:attributes][:current_forecast]).to be_a String

    # array of the next 5 days of daily weather data
    expect(forecast[:data][:attributes]).to have_key(:daily_forecast)
    expect(forecast[:data][:attributes][:daily_forecast].length).to eq(5)
    forecast[:data][:attributes][:daily_forecast].each do |daily_forecast|
      expect(daily_forecast).to have_key(:date)
      expect(daily_forecast[:date]).to be_a String
      expect(daily_forecast).to have_key(:sunrise)
      expect(daily_forecast[:sunrise]).to be_a String
      expect(daily_forecast).to have_key(:sunset)
      expect(daily_forecast[:sunset]).to be_a String
      expect(daily_forecast).to have_key(:max_temp)
      expect(daily_forecast[:max_temp]).to be_a Float
      expect(daily_forecast).to have_key(:min_temp)
      expect(daily_forecast[:min_temp]).to be_a Float
      expect(daily_forecast).to have_key(:conditions)
      expect(daily_forecast[:conditions]).to be_a String # ?
      expect(daily_forecast).to have_key(:icon)
      expect(daily_forecast).to be_a String
    end

    # array of the next 8 hours of hourly weather data
    expect(forecast[:data][:attributes]).to have_key(:hourly_forecast)
    expect(forecast[:data][:attributes][:hourly_forecast].length).to eq(8)
    forecast[:data][:attributes][:hourly_forecast].each do |hourly_forecast|
      expect(hourly_forecast).to have_key(:time)
      expect(hourly_forecast[:time]).to be_a String
      expect(hourly_forecast).to have_key(:temperature)
      expect(hourly_forecast[:temperature]).to be_a Float
      expect(hourly_forecast).to have_key(:conditions)
      expect(hourly_forecast[:conditions]).to be_a String # ?
      expect(hourly_forecast).to have_key(:icon)
      expect(hourly_forecast[:icon]).to be_a String
    end
  end
end

# {
#   "data": {
#     "id": null,
#     "type": "forecast",
#     "attributes": {
#       "current_weather": {
#         "datetime": "2020-09-30 13:27:03 -0600",
#         "temperature": 79.4,
#         etc
#       },
#       "daily_weather": [
#         {
#           "date": "2020-10-01",
#           "sunrise": "2020-10-01 06:10:43 -0600",
#           etc
#         },
#         {...} etc
#       ],
#       "hourly_weather": [
#         {
#           "time": "14:00:00",
#           "conditions": "cloudy with a chance of meatballs",
#           etc
#         },
#         {...} etc
#       ]
#     }
#   }
# }
