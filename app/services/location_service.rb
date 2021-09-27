class LocationService
  def self.find_lat_long(location)
    response = conn.get('/geocoding/v1/address') do |req|
      req.params['key'] = ENV['mapquest_api_key']
      req.params['inFormat'] = 'kvp'
      req.params['outFormat'] = 'json'
      req.params['location'] = location
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://www.mapquestapi.com')
  end
end
