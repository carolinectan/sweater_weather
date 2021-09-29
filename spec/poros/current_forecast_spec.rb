require 'rails_helper'

RSpec.describe CurrentForecast do
  it 'can initialize from current forecast params' do
    current_forecast_params = {
      :dt=>1632891978,
      :sunrise=>1632833607,
      :sunset=>1632876443,
      :temp=>60.13,
      :feels_like=>58.06,
      :pressure=>1009,
      :humidity=>47,
      :dew_point=>39.87,
      :uvi=>0,
      :clouds=>82,
      :visibility=>10000,
      :wind_speed=>5.57,
      :wind_deg=>255,
      :wind_gust=>8.12,
      :weather=>[{:id=>803, :main=>"Clouds", :description=>"broken clouds", :icon=>"04n"}]}

    current = CurrentForecast.new(current_forecast_params)

    expect(current).to be_an_instance_of CurrentForecast
    expect(current.datetime).to eq("2021-09-29 05:06:18 UTC")
    expect(current.sunrise).to eq('2021-09-28 12:53:27 UTC')
    expect(current.sunset).to eq('2021-09-29 00:47:23 UTC')
    expect(current.temperature).to eq(60.13)
    expect(current.feels_like).to eq(58.06)
    expect(current.humidity).to eq(47)
    expect(current.uvi).to eq(0)
    expect(current.visibility).to eq(10000)
    expect(current.conditions).to eq("broken clouds")
    expect(current.icon).to eq("04n")
  end
end
