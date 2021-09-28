class Api::V1::RoadtripSerializer
  def self.get_roadtrip(roadtrip)
    null = nil
    {
      data: {
        id: null,
        type: 'roadtrip',
        attributes: {
          start_city: roadtrip.origin,
          end_city: roadtrip.destination,
          travel_time: travel_time_hr(roadtrip) + travel_time_min(roadtrip)
          weather_at_eta: {
    #         temperature: 59.4,
    #         conditions: "partly cloudy with a chance of meatballs"
          }
        }
      }
    }
  end

  def travel_time_hr(roadtrip)
    "#{roadtrip.travel_time.split(":")[0].to_i} hour(s), "
  end

  def travel_time_min(roadtrip)
    "#{roadtrip.travel_time.split(":")[1].to_i} minute(s)"
  end
end
