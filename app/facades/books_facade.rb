class BooksFacade
  def self.find_books(location, quantity)
    json = BooksService.find_books(location)

    json[:docs][0..(quantity.to_i - 1)].map do |book|
      Book.new
    end
  end
end
