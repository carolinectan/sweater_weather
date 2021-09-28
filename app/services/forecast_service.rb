class ForecastService
  def self.get_forecast(location)
    response = conn.get('/data/2.5/onecall') do |req|
      req.params['appid'] = ENV['open_weather_api_key']
      req.params['lat'] = location.latitude
      req.params['lon'] = location.longitude
      req.params['exclude'] = 'minutely'
      req.params['units'] = 'imperial'
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://api.openweathermap.org')
  end
end
