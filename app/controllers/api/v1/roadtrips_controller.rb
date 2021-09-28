class Api::V1::RoadtripsController < ApplicationController
  def create
    user = User.find_by(api_key: roadtrip_params[:api_key])

    if user.nil? || params[:api_key].nil?
      bad_credentials_error
    else
      roadtrip = RoadtripFacade.get_roadtrip(roadtrip_params[:origin], roadtrip_params[:destination])
      destination = LocationFacade.find_lat_long(roadtrip_params[:destination])
      destination_weather = ForecastFacade.get_hourly_only(destination)

      render json: RoadtripSerializer.get_roadtrip(roadtrip, destination_weather)
    end
  end

  def bad_credentials_error
    render json: {
      message: 'Your request could not be completed.',
      errors: ['Bad credentials.']
    },
           status: :unauthorized # 401
  end

  private

  def roadtrip_params
    params.require(:roadtrip).permit(:origin, :destination, :api_key)
  end
end
