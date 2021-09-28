class RoadtripFacade
  def self.get_roadtrip(origin, destination)
    json = RoadtripService.get_roadtrip(origin, destination)

    Roadtrip.new(json, origin, destination)
  end
end
