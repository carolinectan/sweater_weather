class Api::V1::BookSerializer
  def self.find_books(location, quantity, books, forecast)
    null = nil
    {
      data: {
        id: null,
        type: 'books',
        attributes: {
          destination: location,
          forecast: {
            summary: forecast.current.conditions,
            temperature: "#{forecast.current.temperature} F"
          },
          total_books_found: quantity.to_i,
          books: books.map do |book|
            {
              isbn: book.isbn,
              title: book.title,
              publisher: book.publisher
            }
          end
        }
      }
    }
  end
end
