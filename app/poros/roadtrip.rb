class Roadtrip
  attr_reader :travel_time, :origin, :destination

  def initialize(info, origin, destination)
    @travel_time = info[:route][:formattedTime]
    @origin = origin
    @destination = destination
  end
end
