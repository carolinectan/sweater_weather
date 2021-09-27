class BackgroundService
  def self.get_background(location)
    response = conn.get('/search/photos') do |req|
      req.headers['Accept-Version'] = 'v1'
      req.headers['Authorization'] = ENV['unsplash_api_key']
      req.params['query'] = location
      req.params['page'] = 1
      req.params['per_page'] = 1
      req.params['content_filter'] = 'high'
      req.params['orientation'] = 'landscape'
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://api.unsplash.com')
  end
end
