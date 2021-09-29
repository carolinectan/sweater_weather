require 'rails_helper'

RSpec.describe HourlyForecast do
  it 'can initialize from hourly forecast params' do
    hourly_forecast_params = {
      dt: 1_632_888_000,
      temp: 61.56,
      feels_like: 59.52,
      pressure: 1003,
      humidity: 45,
      dew_point: 40.05,
      uvi: 0,
      clouds: 81,
      visibility: 10_000,
      wind_speed: 6.64,
      wind_deg: 212,
      wind_gust: 8.16,
      weather: [{ id: 803, main: 'Clouds', description: 'broken clouds', icon: '04n' }],
      pop: 0.47
    }

    hourly = HourlyForecast.new(hourly_forecast_params)

    expect(hourly).to be_an_instance_of HourlyForecast
    expect(hourly.time).to eq('2021-09-29 04:00:00 UTC')
    expect(hourly.temperature).to eq(61.56)
    expect(hourly.conditions).to eq('broken clouds')
    expect(hourly.icon).to eq('04n')
  end
end
