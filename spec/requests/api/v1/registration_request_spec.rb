require 'rails_helper'

describe 'Registration API' do
  it 'creates a user in the database and generates a unique api key associated with that user' do
    headers = { 'CONTENT_TYPE': 'application/json', 'Accept': 'application/json' }
    # IMPORTANT REQUIREMENT: Send a JSON payload in the body of the request in Postman, under the address bar, click on “Body”, select “raw”, which will show a dropdown that probably says “Text” in it, choose “JSON” from the list
    # In RSpec, send the request as a param.
    request_body = {
      "email": 'whatever@example.com',
      "password": 'password',
      "password_confirmation": 'password'
    }

    post '/api/v1/users', headers: headers, params: request_body.to_json

    expect(response).to be_successful
    expect(response.status).to eq(201)

    user = JSON.parse(response.body, symbolize_names: true)

    expect(User.last.email).to eq(request_body[:email])

    expect(user).to be_a Hash
    expect(user[:data]).to have_key(:type)
    expect(user[:data][:type]).to be_a String
    expect(user[:data][:type]).to eq('users')
    expect(user[:data]).to have_key(:id)
    expect(user[:data][:id]).to be_a String
    expect(user[:data]).to have_key(:attributes)
    expect(user[:data][:attributes]).to be_a Hash
    expect(user[:data][:attributes].length).to eq(2)
    expect(user[:data][:attributes]).to have_key(:email)
    expect(user[:data][:attributes][:email]).to be_a String
    expect(user[:data][:attributes]).to have_key(:api_key)
    expect(user[:data][:attributes][:api_key]).to be_a String
    expect(user[:data][:attributes][:api_key].length).to eq(27)
    expect(user[:data]).to_not have_key(:password)
    expect(user[:data][:attributes]).to_not have_key(:password)
  end

  it 'returns a 400 status if password and password confirmation do not match' do
    headers = { 'CONTENT_TYPE': 'application/json', 'Accept': 'application/json' }
    # IMPORTANT REQUIREMENT: Send a JSON payload in the body of the request in Postman, under the address bar, click on “Body”, select “raw”, which will show a dropdown that probably says “Text” in it, choose “JSON” from the list
    # In RSpec, send the request as a param.
    request_body = {
      "email": 'whatever@example.com',
      "password": 'password',
      "password_confirmation": 'wrongpassword'
    }

    post '/api/v1/users', headers: headers, params: request_body.to_json

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to_not be_empty
    expect(json.size).to eq(2)
    expect(json[:message]).to eq('Your request could not be completed.')
    expect(json[:errors]).to be_an Array
    expect(json[:errors]).to eq(['Password confirmation must match password.'])
  end

  it 'returns a 400 status if a field is missing' do
    headers = { 'CONTENT_TYPE': 'application/json', 'Accept': 'application/json' }
    # No email or password confirmation included
    request_body = {
      "password": 'password',
    }

    post '/api/v1/users', headers: headers, params: request_body.to_json

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to_not be_empty
    expect(json.size).to eq(2)
    expect(json[:message]).to eq('Your request could not be completed.')
    expect(json[:errors]).to be_an Array
    expect(json[:errors]).to eq(['All fields are required.'])
  end

  it 'returns a 400 status if a the email has already been taken' do
    User.create!(email: 'whatever@example.com',
                 password: 'password',
                 password_confirmation: 'password',
                 api_key: 'k3d6U8Yb8530E35dbdkFF954Aaa')

    headers = { 'CONTENT_TYPE': 'application/json', 'Accept': 'application/json' }
    request_body = {
      "email": User.last.email,
      "password": 'password',
      "password_confirmation": 'password'
    }

    post '/api/v1/users', headers: headers, params: request_body.to_json

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to_not be_empty
    expect(json.size).to eq(2)
    expect(json[:message]).to eq('Your request could not be completed.')
    expect(json[:errors]).to be_an Array
    expect(json[:errors]).to eq(['Email address has already been taken.'])
  end
end
