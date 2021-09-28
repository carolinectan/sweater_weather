class HourlyForecast
  attr_reader :time,
              :temperature,
              :conditions,
              :icon

  def initialize(info)
    @time = Time.at(info[:dt]).utc.to_s
    @temperature = info[:temp]
    @conditions = info[:weather].first[:description]
    @icon = info[:weather].first[:icon]
  end
end
