require 'rails_helper'

describe 'Registration API' do
  it 'creates a user in the database and generates a unique api key associated with that user' do
    headers = { 'CONTENT_TYPE': 'application/json', 'Accept': 'application/json' }
    # In Postman, send the request in the body.
    # In RSpec, send the request as a param.
    request_body = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    post '/api/v1/users', headers: headers, params: request_body

    expect(response).to be_successful
    expect(response.status).to eq(201)

    user = JSON.parse(response.body, symbolize_names: true)

    expect(user).to be_a Hash
    expect(user[:data]).to have_key(:type)
    expect(user[:data][:type]).to be_a String
    expect(user[:data]).to have_key(:id)
    expect(user[:data][:id]).to be_a String
    expect(user[:data]).to have_key(:attributes)
    expect(user[:data][:attributes]).to be_a Hash
    expect(user[:data][:attributes].length).to eq(2)
    expect(user[:data][:attributes]).to have_key(:email)
    expect(user[:data][:attributes][:email]).to be_a String
    expect(user[:data][:attributes]).to have_key(:api_key)
    expect(user[:data][:attributes][:api_key]).to be_a String

    expect(user[:data]).to_not have_key(:password)
    expect(user[:data][:attributes]).to_not have_key(:password)


    # body:
    # {
    #   "data": {
    #     "type": "users",
    #     "id": "1",
    #     "attributes": {
    #       "email": "whatever@example.com",
    #       "api_key": "jgn983hy48thw9begh98h4539h4"
    #     }
    #   }
    # }
    #
    # IMPORTANT REQUIREMENT: This POST endpoint should NOT call your endpoint like /api/v1/users?email=person@woohoo.com&password=abc123&password_confirmation=abc123, and should NOT send as form data either. You must send a JSON payload in the body of the request in Postman, under the address bar, click on “Body”, select “raw”, which will show a dropdown that probably says “Text” in it, choose “JSON” from the list

    # A successful request creates a user in your database, and generates a unique api key associated with that user, with a 201 status code. The response should NOT include the password in any form

    # SAD PATHS:
    # An unsuccessful request returns an appropriate 400-level status code and body with a description of why the request wasn’t successful.
    # Potential reasons a request would fail: passwords don’t match, email has already been taken, missing a field, etc.
  end
end
