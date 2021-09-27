class LocationService
  def self.find_lat_long(location)
    response = conn('https://www.mapquestapi.com/geocoding/v1/address').get do |req|
      req.params['key'] = ENV['mapquest_api_key']
      req.params['inFormat'] = 'kvp'
      req.params['outFormat'] = 'json'
      req.params['location'] = location
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn(endpoint)
    Faraday.new(endpoint)
  end
end
