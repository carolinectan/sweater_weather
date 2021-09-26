class LocationFacade
  def self.find_lat_long(location)
    json = LocationService.find_lat_long(location)
    info = json[:results].first[:locations].first[:latLng]
    Location.new(info)
  end
end
