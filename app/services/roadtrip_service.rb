class RoadtripService
  def self.get_roadtrip(origin, destination)
    response = conn.get('/directions/v2/route') do |req|
      req.params['key'] = ENV['mapquest_api_key']
      req.params['from'] = origin
      req.params['to'] = destination
      req.params['outFormat'] = 'json'
      req.params['ambiguities'] = 'ignore'
      req.params['routeType'] = 'fastest'
      req.params['doReverseGeocode'] = false
      req.params['enhancedNarrative'] = false
      req.params['avoidTimedConditions'] = false
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://www.mapquestapi.com')
  end
end
