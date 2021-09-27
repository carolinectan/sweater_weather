require 'rails_helper'

RSpec.describe BookFacade do
  describe 'class methods' do
    describe '.find_books' do
      it 'returns an array of books', :vcr do
        location = 'denver,co'
        quantity = '5'
        books = BookFacade.find_books(location, quantity)

        expect(books).to be_an Array
        expect(books.first).to be_a Book
        expect(books.size).to eq(5)
      end
    end
  end
end
