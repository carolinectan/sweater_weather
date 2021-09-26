class BackgroundService
  def self.get_background(location)
    response = conn('https://api.unsplash.com/search/collections').get do |req|
      req.headers['Accept-Version'] = 'v1'
      req.headers['Authorization'] = ENV['unsplash_api_key']
      req.params['query'] = location #.split(",").first
      req.params['page'] = 1
      req.params['per_page'] = 1
      req.params['content_filter'] = 'high'
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn(endpoint)
    Faraday.new(endpoint)
  end
end
