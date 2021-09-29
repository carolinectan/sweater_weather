require 'rails_helper'

RSpec.describe DailyForecast do
  it 'can initialize from daily forecast params' do
    daily_forecast_params = {
      dt: 1_632_852_000,
      sunrise: 1_632_833_607,
      sunset: 1_632_876_443,
      moonrise: 1_632_893_220,
      moonset: 1_632_860_280,
      moon_phase: 0.75,
      temp: { day: 78.84, min: 60.19, max: 81, night: 60.19, eve: 77.41, morn: 69.21 },
      feels_like: { day: 78.84, night: 58.15, eve: 75.85, morn: 67.1 },
      pressure: 1002,
      humidity: 18,
      dew_point: 31.78,
      wind_speed: 17.36,
      wind_deg: 137,
      wind_gust: 23.64,
      weather: [{ id: 500, main: 'Rain', description: 'light rain', icon: '10d' }],
      clouds: 52,
      pop: 0.59,
      rain: 0.13,
      uvi: 5.75
    }

    daily = DailyForecast.new(daily_forecast_params)

    expect(daily).to be_an_instance_of DailyForecast
    expect(daily.date).to eq('2021-09-28 18:00:00 UTC')
    expect(daily.sunrise).to eq('2021-09-28 12:53:27 UTC')
    expect(daily.sunset).to eq('2021-09-29 00:47:23 UTC')
    expect(daily.max_temp).to eq(81)
    expect(daily.min_temp).to eq(60.19)
    expect(daily.conditions).to eq('light rain')
    expect(daily.icon).to eq('10d')
  end
end
