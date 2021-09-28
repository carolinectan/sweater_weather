require 'rails_helper'

RSpec.describe BookService do
  describe 'class methods' do
    describe '.find_books' do
      it 'returns books based on search query', :vcr do
        books = BookService.find_books('denver,co')

        expect(books).to be_a Hash
        expect(books).to have_key(:numFound)
        expect(books[:numFound]).to be_an Integer
        expect(books).to have_key(:start)
        expect(books[:start]).to be_an Integer
        expect(books).to have_key(:numFoundExact)
        expect(books[:numFoundExact]).to be_in([true, false])
        expect(books).to have_key(:docs)
        expect(books[:docs]).to be_an Array
        expect(books).to have_key(:num_found)
        expect(books[:num_found]).to be_an Integer
        expect(books).to have_key(:q)
        expect(books[:q]).to be_a String
        expect(books[:q]).to eq('denver+co')
        expect(books).to have_key(:offset)
        expect(books[:offset]).to eq(nil)

        # NOTE: Some keys may not exist for some books
        books[:docs].first do |book|
          expect(book).to have_key(:key)
          expect(book[:key]).to be_a String
          expect(book).to have_key(:text)
          expect(book[:text]).to be_an Array
          expect(book).to have_key(:type)
          expect(book[:type]).to be_a String
          expect(book).to have_key(:seed)
          expect(book[:seed]).to be_an Array
          expect(book).to have_key(:title)
          expect(book[:title]).to be_a String
          expect(book).to have_key(:title_suggest)
          expect(book[:title_suggest]).to be_a String
          expect(book).to have_key(:has_fulltext)
          expect(book[:has_fulltext]).to be_in([true, false])
          expect(book).to have_key(:edition_count)
          expect(book[:edition_count]).to be_an Integer
          expect(book).to have_key(:edition_key)
          expect(book[:edition_key]).to be_an Array
          expect(book).to have_key(:publish_date)
          expect(book[:publish_date]).to be_an Array
          expect(book).to have_key(:publish_year)
          expect(book[:publish_year]).to be_an Array
          expect(book).to have_key(:first_publish_year)
          expect(book[:first_publish_year]).to be_an Integer
          expect(book).to have_key(:isbn)
          expect(book[:isbn]).to be_an Array
          expect(book).to have_key(:last_modified_i)
          expect(book[:last_modified_i]).to be_an Integer
          expect(book).to have_key(:ebook_count_i)
          expect(book[:ebook_count_i]).to be_an Integer
          expect(book).to have_key(:publisher)
          expect(book[:publisher]).to be_an Array
          expect(book).to have_key(:language)
          expect(book[:language]).to be_an Array
          expect(book).to have_key(:author_key)
          expect(book[:author_key]).to be_an Array
          expect(book).to have_key(:author_name)
          expect(book[:author_name]).to be_an Array
          expect(book).to have_key(:publisher_facet)
          expect(book[:publisher_facet]).to be_an Array
          expect(book).to have_key(:_version_)
          expect(book[:_version_]).to be_an Integer
          expect(book).to have_key(:author_facet)
          expect(book[:author_facet]).to be_an Array
        end
      end

      describe '.get_conn' do
        it 'returns a Faraday object for books', :vcr do
          conn = BookService.conn

          expect(conn).to be_a Faraday::Connection
        end
      end
    end
  end
end
