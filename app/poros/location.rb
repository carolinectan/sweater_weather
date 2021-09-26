class Location
  attr_reader :latitude, :longitude

  def initialize(info)
    @latitude = info[:lat]
    @longitude = info[:lng]
  end
end
