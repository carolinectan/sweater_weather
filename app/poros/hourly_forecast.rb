class HourlyForecast
  attr_reader :time,
              :temperature,
              :conditions,
              :icon

  def initialize(info)
    @time = Time.at(info[:dt]).to_s
    @temperature = info[:temp]
    @conditions = info[:weather].first[:description]
    @icon = info[:icon]
  end
end
