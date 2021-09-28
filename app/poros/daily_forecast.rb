class DailyForecast
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon

  def initialize(info)
    @date = Time.at(info[:dt]).utc.to_s
    @sunrise = Time.at(info[:sunrise]).utc.to_s
    @sunset = Time.at(info[:sunset]).utc.to_s
    @max_temp = info[:temp][:max]
    @min_temp = info[:temp][:min]
    @conditions = info[:weather].first[:description]
    @icon = info[:weather].first[:icon]
  end
end
