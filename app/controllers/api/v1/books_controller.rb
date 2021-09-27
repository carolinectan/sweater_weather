class Api::V1::BooksController < ApplicationController
  def index
    books = BookFacade.find_books(params[:location], params[:quantity])
    location = LocationFacade.find_lat_long(params[:location])
    forecast = ForecastFacade.get_forecast(location)

    render json: BookSerializer.find_books(params[:location], params[:quantity], books, forecast)
  end
end
