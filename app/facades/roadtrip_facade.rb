class RoadtripFacade
  def self.get_roadtrip(origin, destination)
    json = RoadtripService.get_roadtrip(origin, destination)

    if !json[:route][:formattedTime].nil?
      Roadtrip.new(json, origin, destination)
    else
      json[:info][:statuscode]
    end
  end
end
