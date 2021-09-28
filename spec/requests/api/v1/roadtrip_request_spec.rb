require 'rails_helper'

describe 'Roadtrip API' do
  it 'sends the roadtrip travel time and weather at eta', :vcr do
    headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
    request_body = {
      origin: 'Denver,CO',
      destination: 'Pueblo,CO',
      api_key: 'jgn983hy48thw9begh98h4539h4'
    }

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

  # travel_time, string, something user-friendly like “2 hours, 13 minutes” or “2h13m” or “02:13:00” or something of that nature (you don’t have to include seconds); set this string to “impossible route” if there is no route between your cities
  # weather_at_eta, conditions at end_city when you arrive (not CURRENT weather), object containing:
  # temperature, numeric value in Fahrenheit
  # note: this object will be blank if the travel time is impossible
  #
  # {
  #   "data": {
  #     "id": null,
  #     "type": "roadtrip",
  #     "attributes": {
  #       "start_city": "Denver, CO",
  #       "end_city": "Estes Park, CO",
  #       "travel_time": "2 hours, 13 minutes"
  #       "weather_at_eta": {
  #         "temperature": 59.4,
  #         "conditions": "partly cloudy with a chance of meatballs"
  #       }
  #     }
  #   }
  # }
  # Requirements:
  #
  # This POST endpoint should NOT call your endpoint like /api/v1/road_trip?origin=Denver,CO&destination=Pueblo,CO&api_key=abc123, and should NOT send as form data either. You must send a JSON payload in the body of the request
  # in Postman, under the address bar, click on “Body”, select “raw”, which will show a dropdown that probably says “Text” in it, choose “JSON” from the list
  # this is a hard requirement to pass this endpoint!
  # API key must be sent
  # If no API key is given, or an incorrect key is provided, return 401 (Unauthorized)
  # You will use MapQuest’s Directions API: https://developer.mapquest.com/documentation/directions-api/
  # The structure of the response should be JSON API 1.0 Compliant.
  # Your code should allow for the following:
  # Traveling from New York, NY to Los Angeles, CA, with appropriate weather in L.A. when you arrive 40 hours later
  # Traveling from New York, NY to London, UK, weather block should be empty and travel time should be “impossible”
  end
end
