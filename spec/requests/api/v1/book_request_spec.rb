require 'rails_helper'

describe 'Books API' do
  it 'sends the books and forcast for a given city and state', :vcr do
    params = { location: 'denver,co', quantity: 5 }
    headers = { 'CONTENT_TYPE': 'application/json', 'Accept': 'application/json' }

    get '/api/v1/book-search', headers: headers, params: params

    expect(response).to be_successful
    expect(response.status).to eq(200)

    books = JSON.parse(response.body, symbolize_names: true)

    expect(books).to be_a Hash
    expect(books[:data]).to have_key(:id)
    expect(books[:data][:id]).to eq(nil)
    expect(books[:data]).to have_key(:type)
    expect(books[:data][:type]).to eq('books')

    expect(books[:data]).to have_key(:attributes)
    expect(books[:data][:attributes].length).to eq(2)
    expect(books[:data][:attributes]).to have_key(:destination)
    expect(books[:data][:attributes][:destination]).to be_a String
    expect(books[:data][:attributes]).to have_key(:forecast)
    expect(books[:data][:attributes][:forecast].length).to eq(2)
    expect(books[:data][:attributes][:forecast]).to have_key(:summary)
    expect(books[:data][:attributes][:forecast][:summary]).to be_a String
    expect(books[:data][:attributes][:forecast]).to have_key(:temperature)
    expect(books[:data][:attributes][:forecast][:temperature]).to be_a String
    expect(books[:data][:attributes]).to have_key(:total_books_found)
    expect(books[:data][:attributes][:total_books_found]).to be_a Integer
    expect(books[:data][:attributes]).to have_key(:books)
    expect(books[:data][:attributes][:books]).to be_an Array
    books[:data][:attributes][:books].each do |book|
      expect(book).to have_key(:isbn)
      expect(book[:isbn]).to be_an Array
      expect(book[:isbn].length).to eq(2)
      expect(book[:isbn][0]).to be_a String
      expect(book[:isbn][1]).to be_a String
      expect(book).to have_key(:title)
      expect(book[:title]).to be_a String
      expect(book).to have_key(:publisher)
      expect(book[:publisher]).to be_an Array
      expect(book[:publisher].length).to eq(1)
      expect(book[:publisher][0]).to be_a String
    end
  end
end

  # You will be using the Open Library API to search for books based on a destination city provided by the user. Presume that your user will give a known “good” location. (you can handle edge cases later)

  # Your API will return:
  # the destination city
  # the forecast in that city right now
  # a quantity of books about the destination city
  # info on each book (isbn, title, and publisher)

  # Your response should be in the format below:
  # {
  #   "data": {
  #     "id": "null",
  #     "type": "books",
  #     "attributes": {
  #       "destination": "denver,co",
  #       "forecast": {
  #         "summary": "Cloudy with a chance of meatballs",
  #         "temperature": "83 F"
  #       },
  #       "total_books_found": 172,
  #       "books": [
  #         {
  #           "isbn": [
  #             "0762507845",
  #             "9780762507849"
  #           ],
  #           "title": "Denver, Co",
  #           "publisher": [
  #             "Universal Map Enterprises"
  #           ]
  #         },
  #         {
  #           "isbn": [
  #             "9780883183663",
  #             "0883183668"
  #           ],
  #           "title": "Photovoltaic safety, Denver, CO, 1988",
  #           "publisher": [
  #             "American Institute of Physics"
  #           ]
  #         },
  #         { ... same format for books 3, 4 and 5 ... }
  #       ]
  #     }
  #   }
  # }
