class Weather
  attr_reader :current, :daily, :hourly

  def initialize(current, daily, hourly)
    @current = current # 1 CurrentForecast object
    @daily = daily # Array of 5 DailyForecast objects
    @hourly = hourly # Array of 8 HourlyForecast objects
  end
end
