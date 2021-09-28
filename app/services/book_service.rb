class BookService
  def self.find_books(location)
    location = location.tr(',', '+') if location.include?(',')

    response = conn.get('/search.json') do |req|
      req.params['q'] = location
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('http://openlibrary.org')
  end
end
