require 'rails_helper'

describe 'Login API' do
  it "sends the user's api key", :vcr do
    User.create!(email: 'whatever@example.com',
                 password: 'password',
                 password_confirmation: 'password',
                 api_key: 'k3d6U8Yb8530E35dbdkFF954Aaa')

    headers = { 'CONTENT_TYPE': 'application/json', 'Accept': 'application/json' }
    # REQUIREMENT: Send a JSON payload in the body of the request in Postman, under the address bar, click on “Body”, select “raw”, which will show a dropdown that probably says “Text” in it, choose “JSON” from the list
    # In RSpec, send the request as a param.
    request_body = {
      "email": 'whatever@example.com',
      "password": 'password'
    }

    post '/api/v1/sessions', headers: headers, params: request_body.to_json

    expect(response).to be_successful
    expect(response.status).to eq(200)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to be_a Hash
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to be_a String
    expect(json[:data][:type]).to eq('users')
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to be_a String
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a Hash
    expect(json[:data][:attributes].length).to eq(2)
    expect(json[:data][:attributes]).to have_key(:email)
    expect(json[:data][:attributes][:email]).to be_a String
    expect(json[:data][:attributes]).to have_key(:api_key)
    expect(json[:data][:attributes][:api_key]).to be_a String
    expect(json[:data][:attributes][:api_key].length).to eq(27)
  end
end

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

# A successful request returns the user’s api key.

# An unsuccessful request returns an appropriate 400-level status code and body with a description of why the request wasn’t successful.

# Potential reasons a request would fail: credentials are bad, etc

# Security tip: never tell a user which field (email/password) is incorrect, as this alerts malicious users how to attack your site (eg, if they’ve guessed a correct email address, and you tell them the password is bad, then they don’t need to keep guessing email addresses, and can just try to crack the password)
