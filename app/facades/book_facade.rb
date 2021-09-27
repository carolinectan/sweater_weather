class BookFacade
  def self.find_books(location, quantity)
    json = BookService.find_books(location)

    json[:docs][0..(quantity.to_i - 1)].map do |book|
      Book.new(book)
    end
  end
end
