require 'rails_helper'

describe 'Weather API' do
  it 'sends the forcast for a given city and state', :vcr do
    location = { location: 'denver,co' }
    headers = { 'CONTENT_TYPE': 'application/json', 'Accept': 'application/json' }

    get '/api/v1/forecast', headers: headers, params: location

    expect(response).to be_successful
    expect(response.status).to eq(200)

    forecast = JSON.parse(response.body, symbolize_names: true)

    expect(forecast).to be_a Hash
    expect(forecast[:data]).to have_key(:id)
    expect(forecast[:data][:id]).to eq(nil)
    expect(forecast[:data]).to have_key(:type)
    expect(forecast[:data][:type]).to eq('forecast')
    expect(forecast[:data]).to have_key(:attributes)
    expect(forecast[:data][:attributes].length).to eq(3)

    # holds current weather data
    expect(forecast[:data][:attributes]).to have_key(:current_weather)
    expect(forecast[:data][:attributes][:current_weather]).to have_key(:datetime)
    expect(forecast[:data][:attributes][:current_weather][:datetime]).to be_a String
    expect(forecast[:data][:attributes][:current_weather]).to have_key(:sunrise)
    expect(forecast[:data][:attributes][:current_weather][:sunrise]).to be_a String
    expect(forecast[:data][:attributes][:current_weather]).to have_key(:sunset)
    expect(forecast[:data][:attributes][:current_weather][:sunset]).to be_a String
    expect(forecast[:data][:attributes][:current_weather]).to have_key(:temperature)
    expect(forecast[:data][:attributes][:current_weather][:temperature]).to be_a Float
    expect(forecast[:data][:attributes][:current_weather]).to have_key(:feels_like)
    expect(forecast[:data][:attributes][:current_weather][:feels_like]).to be_a Float
    expect(forecast[:data][:attributes][:current_weather]).to have_key(:humidity)
    expect(forecast[:data][:attributes][:current_weather][:humidity]).to be_an Integer
    expect(forecast[:data][:attributes][:current_weather]).to have_key(:uvi)
    expect(forecast[:data][:attributes][:current_weather][:uvi]).to be_a Float
    expect(forecast[:data][:attributes][:current_weather]).to have_key(:visibility)
    expect(forecast[:data][:attributes][:current_weather][:visibility]).to be_an Integer
    expect(forecast[:data][:attributes][:current_weather]).to have_key(:conditions)
    expect(forecast[:data][:attributes][:current_weather][:conditions]).to be_a String
    expect(forecast[:data][:attributes][:current_weather]).to have_key(:icon)
    expect(forecast[:data][:attributes][:current_weather][:icon]).to be_a String

    # array of the next 5 days of daily weather data
    expect(forecast[:data][:attributes]).to have_key(:daily_weather)
    expect(forecast[:data][:attributes][:daily_weather].length).to eq(5)
    forecast[:data][:attributes][:daily_weather].each do |daily_weather|
      expect(daily_weather).to have_key(:date)
      expect(daily_weather[:date]).to be_a String
      expect(daily_weather).to have_key(:sunrise)
      expect(daily_weather[:sunrise]).to be_a String
      expect(daily_weather).to have_key(:sunset)
      expect(daily_weather[:sunset]).to be_a String
      expect(daily_weather).to have_key(:max_temp)
      expect(daily_weather[:max_temp]).to be_a Float
      expect(daily_weather).to have_key(:min_temp)
      expect(daily_weather[:min_temp]).to be_a Float
      expect(daily_weather).to have_key(:conditions)
      expect(daily_weather[:conditions]).to be_a String
      expect(daily_weather).to have_key(:icon)
      expect(daily_weather[:icon]).to be_a String
    end

    # array of the next 8 hours of hourly weather data
    expect(forecast[:data][:attributes]).to have_key(:hourly_weather)
    expect(forecast[:data][:attributes][:hourly_weather].length).to eq(8)
    forecast[:data][:attributes][:hourly_weather].each do |hourly_weather|
      expect(hourly_weather).to have_key(:time)
      expect(hourly_weather[:time]).to be_a String
      expect(hourly_weather).to have_key(:temperature)
      expect(hourly_weather[:temperature]).to be_a Float
      expect(hourly_weather).to have_key(:conditions)
      expect(hourly_weather[:conditions]).to be_a String
      expect(hourly_weather).to have_key(:icon)
      expect(hourly_weather[:icon]).to be_a String
    end
  end
end
