class RoadtripSerializer
  include FastJsonapi::ObjectSerializer

  def self.get_roadtrip(roadtrip, weather)
    null = nil
    {
      data: {
        id: null,
        type: 'roadtrip',
        attributes: {
          start_city: roadtrip.origin,
          end_city: roadtrip.destination,
          travel_time: "#{roadtrip.travel_hr} hr, #{roadtrip.travel_min} min",
          weather_at_eta: {
            temperature: weather[roadtrip.travel_hr - 1].temperature,
            conditions: weather[roadtrip.travel_hr - 1].conditions
          }
        }
      }
    }
  end

  def self.impossible_route(roadtrip_params)
    null = nil
    {
      data: {
        id: null,
        type: 'roadtrip',
        attributes: {
          start_city: roadtrip_params[:origin],
          end_city: roadtrip_params[:destination],
          travel_time: 'Impossible route',
          weather_at_eta: {
            temperature: null,
            conditions: null
          }
        }
      }
    }
  end
end
