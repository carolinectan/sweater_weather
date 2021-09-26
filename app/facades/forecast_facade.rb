class ForecastFacade
  def self.get_forecast(location)
    json = ForecastService.get_forecast(location)

    current_forecast = CurrentForecast.new(json[:current])
    daily_forecast = json[:daily][0..4].each do |daily|
      DailyForecast.new(daily)
    end
    hourly_forecast = json[:hourly][0..7].each do |hourly|
      HourlyForecast.new(hourly)
    end
  end
end
