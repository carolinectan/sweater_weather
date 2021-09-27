require 'rails_helper'

describe 'Background Image API' do
  it 'sends the background image for a city', :vcr do
    location = { location: 'denver,co' }
    headers = { 'CONTENT_TYPE': 'application/json', 'Accept': 'application/json' }

    get '/api/v1/backgrounds', headers: headers, params: location

    expect(response).to be_successful
    expect(response.status).to eq(200)

    background = JSON.parse(response.body, symbolize_names: true)

    expect(background).to be_a Hash
    expect(background[:data]).to have_key(:id)
    expect(background[:data][:id]).to eq(nil)
    expect(background[:data]).to have_key(:type)
    expect(background[:data][:type]).to eq('image')
    expect(background[:data]).to have_key(:attributes)
    expect(background[:data][:attributes].length).to eq(1)

    expect(background[:data][:attributes][:image].length).to eq(3)

    expect(background[:data][:attributes][:image]).to have_key(:description)
    expect(background[:data][:attributes][:image][:description].length).to eq(3)
    expect(background[:data][:attributes][:image][:description]).to have_key(:description)
    expect(background[:data][:attributes][:image][:description][:description]).to be_a String
    expect(background[:data][:attributes][:image][:description]).to have_key(:alt_description)
    expect(background[:data][:attributes][:image][:description][:alt_description]).to be_a String
    expect(background[:data][:attributes][:image][:description]).to have_key(:location)
    expect(background[:data][:attributes][:image][:description][:location]).to be_a String
    expect(background[:data][:attributes][:image]).to have_key(:image_url)
    expect(background[:data][:attributes][:image][:image_url]).to be_a String
    expect(background[:data][:attributes][:image][:credit].length).to eq(6)
    expect(background[:data][:attributes][:image][:credit]).to have_key(:source)
    expect(background[:data][:attributes][:image][:credit][:source]).to be_a String
    expect(background[:data][:attributes][:image][:credit]).to have_key(:photographer)
    expect(background[:data][:attributes][:image][:credit][:photographer]).to be_a String
    expect(background[:data][:attributes][:image][:credit]).to have_key(:profile)
    expect(background[:data][:attributes][:image][:credit][:profile]).to be_a String
    expect(background[:data][:attributes][:image][:credit]).to have_key(:logo)
    expect(background[:data][:attributes][:image][:credit][:logo]).to be_a String
    expect(background[:data][:attributes][:image][:credit]).to have_key(:utm_source)
    expect(background[:data][:attributes][:image][:credit][:utm_source]).to be_a String
    expect(background[:data][:attributes][:image][:credit]).to have_key(:utm_medium)
    expect(background[:data][:attributes][:image][:credit][:utm_medium]).to be_a String

    # Extension:
    # Determine the time of day and current weather and include that in your search;
    # for example, searching for “denver evening snow” might return a far more interesting result
  end
end
