class Weather
  attr_reader :current, :daily, :hourly

  def initialize(current, daily, hourly)
    @current = current
    @daily = daily
    @hourly = hourly
  end
end
