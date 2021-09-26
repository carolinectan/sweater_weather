class Api::V1::ForecastController < ApplicationController
  def index
    location = LocationFacade.find_lat_long(params[:location])
    # can call location.latitude and location.longitude


require "pry"; binding.pry
    # forecast = Forecast.new(data)
    # render json: ForecastSerializer.new(params[:location])
  end
end
