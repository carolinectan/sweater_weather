class ForecastFacade
  def self.get_forecast(location)
    json = ForecastService.get_forecast(location)

    current_forecast = CurrentForecast.new(json[:current])
    daily_forecast = json[:daily][0..4].map do |daily|
      DailyForecast.new(daily)
    end
    hourly_forecast = json[:hourly][0..7].map do |hourly|
      HourlyForecast.new(hourly)
    end

    Weather.new(current_forecast, daily_forecast, hourly_forecast)
  end

  def self.get_hourly_only(location)
    json = ForecastService.get_forecast(location)

    json[:hourly][0..47].map do |hourly|
      HourlyForecast.new(hourly)
    end
  end
end
