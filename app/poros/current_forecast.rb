class CurrentForecast
  attr_reader :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon

  def initialize(info)
    @datetime = Time.at(info[:dt]).utc.to_s
    @sunrise = Time.at(info[:sunrise]).utc.to_s
    @sunset = Time.at(info[:sunset]).utc.to_s
    @temperature = info[:temp]
    @feels_like = info[:feels_like]
    @humidity = info[:humidity]
    @uvi = info[:uvi]
    @visibility = info[:visibility]
    @conditions = info[:weather].first[:description]
    @icon = info[:weather].first[:icon]
  end
end
