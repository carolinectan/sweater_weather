require 'rails_helper'

RSpec.describe BookFacade do
  describe 'class methods' do
    describe '.find_books' do
      it 'returns an array of books', :vcr do
        location = 'denver,co'
        quantity = '7'
        books = BookFacade.find_books(location, quantity)

        expect(books).to be_an Array
        expect(books.size).to eq(7)
        expect(books.first).to be_a Book
        expect(books.first.isbn).to be_an Array
        expect(books.first.isbn[0]).to be_a String
        expect(books.first.title).to be_a String
        expect(books.first.title).to eq('Denver, Co')
        expect(books.first.publisher).to be_an Array
        expect(books.first.publisher).to eq(['Universal Map Enterprises'])
      end
    end
  end
end
