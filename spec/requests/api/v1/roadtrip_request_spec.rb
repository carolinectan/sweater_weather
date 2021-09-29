require 'rails_helper'

describe 'Roadtrip API' do
  it 'sends the roadtrip travel time and weather at eta', :vcr do
    User.create!(email: 'whatever@example.com',
                 password: 'password',
                 password_confirmation: 'password',
                 api_key: 'jgn983hy48thw9begh98h4539h4')

    headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
    request_body = {
      origin: 'New York,NY',
      destination: 'Los Angeles,CA',
      api_key: 'jgn983hy48thw9begh98h4539h4'
    }
    # REQUIREMENTS: This POST endpoint should NOT call your endpoint like
    # /api/v1/road_trip?origin=Denver,CO&destination=Pueblo,CO&api_key=abc123,
    # and should NOT send as form data either. You must send a JSON payload in the
    # body of the request in Postman, under the address bar, click on “Body”,
    # select “raw”, which will show a dropdown that probably says “Text” in it,
    # choose “JSON” from the list

    post '/api/v1/road_trip', headers: headers, params: request_body.to_json

    expect(response).to be_successful
    expect(response.status).to eq(200)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to be_a Hash
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to eq(nil)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq('roadtrip')

    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a Hash
    expect(json[:data][:attributes].length).to eq(4)
    expect(json[:data][:attributes]).to have_key(:start_city)
    expect(json[:data][:attributes][:start_city]).to be_a String
    expect(json[:data][:attributes]).to have_key(:end_city)
    expect(json[:data][:attributes][:end_city]).to be_a String
    expect(json[:data][:attributes]).to have_key(:travel_time)
    expect(json[:data][:attributes][:travel_time]).to be_a String
    expect(json[:data][:attributes]).to have_key(:weather_at_eta)
    expect(json[:data][:attributes][:weather_at_eta]).to be_a Hash
    expect(json[:data][:attributes][:weather_at_eta].length).to eq(2)
    expect(json[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
    expect(json[:data][:attributes][:weather_at_eta][:temperature]).to be_a Numeric
    expect(json[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
    expect(json[:data][:attributes][:weather_at_eta][:conditions]).to be_a String
  end

  it 'sends a 401 if the user does not exist', :vcr do
    headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
    request_body = {
      origin: 'Denver,CO',
      destination: 'Pueblo,CO',
      api_key: 'jgn983hy48thw9begh98h4539h4'
    }

    post '/api/v1/road_trip', headers: headers, params: request_body.to_json

    expect(response).to_not be_successful
    expect(response.status).to eq(401)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to be_a Hash
    expect(json).to_not be_empty
    expect(json.size).to eq(2)
    expect(json[:message]).to eq('Your request could not be completed.')
    expect(json[:errors]).to be_an Array
    expect(json[:errors]).to eq(['Bad credentials.'])
  end

  it 'sends a 401 if the api key does not match one in the database', :vcr do
    headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
    request_body = {
      origin: 'Fort Collins,CO',
      destination: 'Boulder,CO',
      api_key: 'jgn983hy48thw9begh98h4539h4'
    }

    post '/api/v1/road_trip', headers: headers, params: request_body.to_json

    expect(response).to_not be_successful
    expect(response.status).to eq(401)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to be_a Hash
    expect(json).to_not be_empty
    expect(json.size).to eq(2)
    expect(json[:message]).to eq('Your request could not be completed.')
    expect(json[:errors]).to be_an Array
    expect(json[:errors]).to eq(['Bad credentials.'])
  end

  it 'sends a 401 if the api key is not provided', :vcr do
    headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
    request_body = {
      origin: 'Denver,CO',
      destination: 'Pueblo,CO'
    }

    post '/api/v1/road_trip', headers: headers, params: request_body.to_json

    expect(response).to_not be_successful
    expect(response.status).to eq(401)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to be_a Hash
    expect(json).to_not be_empty
    expect(json.size).to eq(2)
    expect(json[:message]).to eq('Your request could not be completed.')
    expect(json[:errors]).to be_an Array
    expect(json[:errors]).to eq(['Bad credentials.'])
  end

  it 'sends message for an impossible route', :vcr do
    User.create!(email: 'whatever@example.com',
                 password: 'password',
                 password_confirmation: 'password',
                 api_key: 'jgn983hy48thw9begh98h4539h4')

    headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
    request_body = {
      origin: 'New York,NY',
      destination: 'London, UK',
      api_key: 'jgn983hy48thw9begh98h4539h4'
    }
    # REQUIREMENTS: This POST endpoint should NOT call your endpoint like
    # /api/v1/road_trip?origin=Denver,CO&destination=Pueblo,CO&api_key=abc123,
    # and should NOT send as form data either. You must send a JSON payload in the
    # body of the request in Postman, under the address bar, click on “Body”,
    # select “raw”, which will show a dropdown that probably says “Text” in it,
    # choose “JSON” from the list

    post '/api/v1/road_trip', headers: headers, params: request_body.to_json

    expect(response).to be_successful
    expect(response.status).to eq(200)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to be_a Hash
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to eq(nil)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq('roadtrip')
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a Hash
    expect(json[:data][:attributes].length).to eq(4)
    expect(json[:data][:attributes]).to have_key(:start_city)
    expect(json[:data][:attributes][:start_city]).to be_a String
    expect(json[:data][:attributes]).to have_key(:end_city)
    expect(json[:data][:attributes][:end_city]).to be_a String
    expect(json[:data][:attributes]).to have_key(:travel_time)
    expect(json[:data][:attributes][:travel_time]).to be_a String
    expect(json[:data][:attributes][:travel_time]).to eq('Impossible route')
    expect(json[:data][:attributes]).to have_key(:weather_at_eta)
    expect(json[:data][:attributes][:weather_at_eta]).to be_a Hash
    expect(json[:data][:attributes][:weather_at_eta].length).to eq(2)
    expect(json[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
    expect(json[:data][:attributes][:weather_at_eta][:temperature]).to eq(nil)
    expect(json[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
    expect(json[:data][:attributes][:weather_at_eta][:conditions]).to eq(nil)
  end
end
