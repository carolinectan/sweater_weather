class HourlyForecast
  attr_reader :time,
              :temperature,
              :conditions,
              :icon

  def initialize(info)
    @time = info[:dt]
    @temperature = info[:temp]
    @conditions = info[:weather].first[:description]
    @icon = info[:icon]
  end
end
