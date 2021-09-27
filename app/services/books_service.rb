class BooksService
  def self.find_books(location)
    if location.include?(',')
      location = location.gsub(',','+')
    end

    response = conn.get('/search.json') do |req|
      req.params['q'] = location
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('http://openlibrary.org')
  end
end
