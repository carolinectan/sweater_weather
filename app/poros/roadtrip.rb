class Roadtrip
  attr_reader :travel_time, :travel_hr, :travel_min, :origin, :destination

  def initialize(info, origin, destination)
    @travel_time = info[:route][:formattedTime]
    @travel_hr = @travel_time.split(':')[0].to_i
    @travel_min = @travel_time.split(':')[1].to_i
    @origin = origin
    @destination = destination
  end
end
