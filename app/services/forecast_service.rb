class ForecastService
  def self.get_forecast(location)
    response = conn('https://api.openweathermap.org/data/2.5/onecall').get do |req|
      req.params['appid'] = ENV['open_weather_api_key']
      req.params['lat'] = location.latitude
      req.params['lon'] = location.longitude
      req.params['exclude'] = 'minutely'
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn(endpoint)
    Faraday.new(endpoint)
  end
end
