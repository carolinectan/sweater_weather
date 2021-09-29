class RoadtripFacade
  def self.get_roadtrip(origin, destination)
    json = RoadtripService.get_roadtrip(origin, destination)

    if json[:route][:formattedTime].nil?
      json[:info][:statuscode]
    else
      Roadtrip.new(json, origin, destination)
    end
  end
end
