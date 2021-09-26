class Api::V1::ForecastController < ApplicationController
  def index
    location = LocationFacade.find_lat_long(params[:location])
    forecast = ForecastFacade.get_forecast(location)

    render json: ForecastSerializer.get_weather(forecast)
  end
end
