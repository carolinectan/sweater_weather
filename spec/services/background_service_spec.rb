require 'rails_helper'

RSpec.describe BackgroundService do
  describe 'class methods' do
    describe '.get_background' do
      it 'returns background based on location', :vcr do
        background = BackgroundService.get_background('denver,co')

        expect(background).to be_a Hash
        expect(background).to have_key(:total)
        expect(background[:total]).to be_a Numeric
        expect(background).to have_key(:total_pages)
        expect(background[:total_pages]).to be_a Numeric
        expect(background).to have_key(:results)
        expect(background[:results]).to be_an Array
        expect(background[:results][0]).to have_key(:id)
        expect(background[:results][0][:id]).to be_a String
        expect(background[:results][0]).to have_key(:created_at)
        expect(background[:results][0][:created_at]).to be_a String
        expect(background[:results][0]).to have_key(:updated_at)
        expect(background[:results][0][:updated_at]).to be_a String
        expect(background[:results][0]).to have_key(:promoted_at)
        expect(background[:results][0][:promoted_at]).to eq(nil)
        expect(background[:results][0]).to have_key(:width)
        expect(background[:results][0][:width]).to be_a Numeric
        expect(background[:results][0]).to have_key(:height)
        expect(background[:results][0][:height]).to be_a Numeric
        expect(background[:results][0]).to have_key(:color)
        expect(background[:results][0][:color]).to be_a String
        expect(background[:results][0]).to have_key(:blur_hash)
        expect(background[:results][0][:blur_hash]).to be_a String
        expect(background[:results][0]).to have_key(:description)
        expect(background[:results][0][:description]).to be_a String
        expect(background[:results][0]).to have_key(:alt_description)
        expect(background[:results][0][:alt_description]).to be_a String
        expect(background[:results][0]).to have_key(:urls)
        expect(background[:results][0][:urls]).to be_a Hash
      end
    end

    describe '.get_conn' do
      it 'returns a Faraday object for a background', :vcr do
        conn = BackgroundService.conn

        expect(conn).to be_a Faraday::Connection
      end
    end
  end
end
