class Api::V1::RoadtripSerializer
  def self.get_roadtrip(roadtrip, destination_weather)
    null = nil
    {
      data: {
        id: null,
        type: 'roadtrip',
        attributes: {
          start_city: roadtrip.origin,
          end_city: roadtrip.destination,
          travel_time: "#{roadtrip.travel_time.split(':')[0].to_i} hour(s), #{roadtrip.travel_time.split(':')[1].to_i} minute(s)",
          weather_at_eta: {
            temperature: destination_weather[roadtrip.travel_time.split(':')[0].to_i - 1].temperature,
            conditions: destination_weather[roadtrip.travel_time.split(':')[1].to_i - 1].conditions
          }
        }
      }
    }
  end

  # def self.impossible_route(roadtrip_params)
  #   null = nil
  #   {
  #     data: {
  #       id: null,
  #       type: 'roadtrip',
  #       attributes: {
  #         start_city: roadtrip_params[:origin],
  #         end_city: roadtrip_params[:destination],
  #         travel_time: 'Impossible route',
  #         weather_at_eta: {
  #           temperature: null,
  #           conditions: null
  #         }
  #       }
  #     }
  #   }
  # end
end
