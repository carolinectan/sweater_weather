# Sweater Weather
![sweater-leaves-pexels-saliha-7642067](https://user-images.githubusercontent.com/81220681/135049580-718bf7e3-9126-4575-a850-362c0a8b80cb.jpg)

## Overview
Welcome to Sweather Weather! This Ruby on Rails API application helps plan road trips. This app will allow users to see the current weather as well as the forecasted weather at the destination.

In this service-oriented architecture, the (theoretical) front-end team will communicate with this back-end application through an API. Sweater Weather exposes the API that satisfies the front-end team’s requirements.

Sweather Weather consumes the MapQuest Developer API, the Open Weather Map API, the Unsplash API, and the Open Library API then aggregates their data. This app also exposes an API that requires an authentication token, exposes an API for CRUD functionality, and structures responses that are JSON API 1.0 Compliant.

## Table of Contents
- [Technologies](#technologies)
- [System Dependencies](#system-dependencies)
- [Configuration](#configuration)
- [Database Creation](#database-creation)
- [How to Run the Test Suite](#how-to-run-the-test-suite)
<!-- - [Screenshots](#screenshots) -->
- [Endpoints](#endpoints)
  - [Retrieve Weather for a City](#retrieve-weather-for-a-city)
  - [Background Image for a City](#background-image-for-a-city)
  - [Book Search](#book-search)
  - [User Registration](#user-registration)
  - [Login](#login)
  - [Road Trip](#road-trip)

## Technologies
|Development|Development|Testing
|--- |--- |--- |
|[Rails 5.2.6](https://rubygems.org/gems/rails/versions/5.2.6)|[Git](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)|[RSpec for Rails](https://github.com/rspec/rspec-rails)
|[Ruby 2.7.2](https://www.ruby-lang.org/en/downloads/)|[Github](https://desktop.github.com/)|[Capybara](https://github.com/teamcapybara/capybara)
|[Pry](https://rubygems.org/gems/pry/versions/0.10.3)|[FastJSONApi](https://github.com/Netflix/fast_jsonapi)|[Webmock](https://github.com/bblimke/webmock)
|[PostgresQL](https://www.postgresql.org/)|[BCrypt](https://github.com/bcrypt-ruby/bcrypt-ruby)|[VCR](https://github.com/vcr/vcr)
|[Faraday](https://github.com/lostisland/faraday)|[Rubocop](https://rubygems.org/gems/rubocop/versions/0.39.0)|[shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)|[Figaro](https://github.com/laserlemon/figaro)|[Atom](https://atom.io/)|[Postman](https://www.postman.com/product/rest-client/)
|||[SimpleCov](https://rubygems.org/gems/simplecov/versions/0.12.0)

## System Dependencies
You will need to sign up for the MapQuest Developer, Open Weather Map, and Unsplash api keys.

- [MapQuest Developer API](https://developer.mapquest.com/documentation/)
  - [Sign up for an account with MapQuest](https://developer.mapquest.com/plan_purchase/steps/business_edition/business_edition_free/register)
  - Then, [get your key here](https://developer.mapquest.com/user/me/apps) then select `Create a New Key` and fill in required fields.
- [Open Weather Map API](https://openweathermap.org/api)
  - [Sign up](https://home.openweathermap.org/users/sign_up)
  - Go to [your API keys](https://home.openweathermap.org/api_keys), fill in API key name, and select `Generate`.
- [Unsplash API ](https://unsplash.com/documentation)
  - First, login or [join](https://unsplash.com/join)
  - Then register your application. Go to [your apps](https://unsplash.com/oauth/applications), click `New Application`, and fill in the required details.
  - NOTE: All applications must follow the [API Guidelines](https://help.unsplash.com/en/articles/2511245-unsplash-api-guidelines), including [properly providing attribution for the photographer and Unsplash](https://help.unsplash.com/en/articles/2511315-guideline-attribution).
- [Open Library API](https://openlibrary.org/dev/docs/api/search)
  - No authorization key required
  
## Configuration
  - Clone this repo
  - Run `bundle`
  - Run `bundle exec figaro install`
  - Open your `config/application.yml` file in your code editor (You may have to open it manually). Then, add to the bottom of the `config/application.yml` file **your** api keys:
```
open_weather_api_key: <your_open_weather_api_key>
mapquest_api_key: <your_mapquest_api_key>
unsplash_api_key: Client-ID <your_unsplash_api_key>
```

## Database Creation
  - Run `rails db:{create,migrate}`

## How to Run the Test Suite
### RSpec:
- Delete spec/fixtures/vcr_cassettes, then run `bundle exec rspec`
### Postman:
- In Terminal, run `rails s`
- In Postman, set appropriate HTTP verb, append endpoint URI to `http://localhost:3000/`, and select `SEND`.
- NOTE: For `post` requests, send a JSON payload in the body of the request in Postman. Under the address bar, click on `Body`, select `raw`, and from the dropdown that probably says `Text` in it, choose `JSON`.

## Endpoints

### Retrieve Weather for a City
#### Request
```
GET /api/v1/forecast?location=denver,co
Content-Type: application/json
Accept: application/json
```
#### 200 Response
```
{:data=>
  {:id=>nil,
   :type=>"forecast",
   :attributes=>
    {:current_weather=>
      {:datetime=>"2021-09-28 23:45:49 UTC",
       :sunrise=>"2021-09-28 12:53:27 UTC",
       :sunset=>"2021-09-29 00:47:23 UTC",
       :temperature=>72.21,
       :feels_like=>70.74,
       :humidity=>34,
       :uvi=>0.24,
       :visibility=>10000,
       :conditions=>"scattered clouds",
       :icon=>"03d"},
     :daily_weather=>
      [{:date=>"2021-09-28 18:00:00 UTC",
        :sunrise=>"2021-09-28 12:53:27 UTC",
        :sunset=>"2021-09-29 00:47:23 UTC",
        :max_temp=>80.42,
        :min_temp=>66.81,
        :conditions=>"scattered clouds",
        :icon=>"03d"},
       {:date=>"2021-09-29 18:00:00 UTC",
        :sunrise=>"2021-09-29 12:54:24 UTC",
        :sunset=>"2021-09-30 00:45:45 UTC",
        :max_temp=>71.64,
        :min_temp=>51.89,
        :conditions=>"heavy intensity rain",
        :icon=>"10d"},
       {:date=>"2021-09-30 18:00:00 UTC",
        :sunrise=>"2021-09-30 12:55:21 UTC",
        :sunset=>"2021-10-01 00:44:07 UTC",
        :max_temp=>60.91,
        :min_temp=>50.45,
        :conditions=>"moderate rain",
        :icon=>"10d"},
       {:date=>"2021-10-01 18:00:00 UTC",
        :sunrise=>"2021-10-01 12:56:19 UTC",
        :sunset=>"2021-10-02 00:42:29 UTC",
        :max_temp=>69.57,
        :min_temp=>53.56,
        :conditions=>"few clouds",
        :icon=>"02d"},
       {:date=>"2021-10-02 18:00:00 UTC",
        :sunrise=>"2021-10-02 12:57:16 UTC",
        :sunset=>"2021-10-03 00:40:52 UTC",
        :max_temp=>72.86,
        :min_temp=>57.49,
        :conditions=>"clear sky",
        :icon=>"01d"}],
     :hourly_weather=>
      [{:time=>"2021-09-28 23:00:00 UTC",
        :temperature=>73.49,
        :conditions=>"scattered clouds",
        :icon=>"03d"},
       {:time=>"2021-09-29 00:00:00 UTC",
        :temperature=>72.21,
        :conditions=>"scattered clouds",
        :icon=>"03d"},
       {:time=>"2021-09-29 01:00:00 UTC",
        :temperature=>71.85,
        :conditions=>"scattered clouds",
        :icon=>"03n"},
       {:time=>"2021-09-29 02:00:00 UTC",
        :temperature=>70.9,
        :conditions=>"broken clouds",
        :icon=>"04n"},
       {:time=>"2021-09-29 03:00:00 UTC",
        :temperature=>70.3,
        :conditions=>"broken clouds",
        :icon=>"04n"},
       {:time=>"2021-09-29 04:00:00 UTC",
        :temperature=>68.7,
        :conditions=>"broken clouds",
        :icon=>"04n"},
       {:time=>"2021-09-29 05:00:00 UTC",
        :temperature=>66.81,
        :conditions=>"overcast clouds",
        :icon=>"04n"},
       {:time=>"2021-09-29 06:00:00 UTC",
        :temperature=>65.86,
        :conditions=>"overcast clouds",
        :icon=>"04n"}]}}}
```

<hr>

### Background Image for a City
#### Request
```
GET /api/v1/forecast?location=denver,co
Content-Type: application/json
Accept: application/json
```
#### 200 Response
```
{:data=>
  {:id=>nil,
   :type=>"image",
   :attributes=>
    {:image=>
      {:description=>
        {:description=>"Night Time Downtown Denver",
         :alt_description=>"city skyline during night time",
         :location=>"denver,co"},
       :image_url=>
        "https://images.unsplash.com/photo-1619856699906-09e1f58c98b1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjM0MTR8MHwxfHNlYXJjaHwxfHxkZW52ZXIlMkNjb3xlbnwxfDB8fHwxNjMyODU0NDU1&ixlib=rb-1.2.1&q=80&w=1080",
       :credit=>
        {:source=>"upsplash.com",
         :photographer=>"Ryan De Hamer",
         :profile=>"https://unsplash.com/@rdehamer",
         :logo=>"https://unsplash.com/blog/content/images/max/2560/1-VnKoValwGK3-d1bZhD6sVA.jpeg",
         :utm_source=>"Sweater Weather",
         :utm_medium=>"referral"}}}}}
```

<hr>

### Book Search
#### Request
```
GET /api/v1/book-search?location=denver,co&quantity=5
```
#### Response
```
{:data=>
  {:id=>nil,
   :type=>"books",
   :attributes=>
    {:destination=>"denver,co",
     :forecast=>{:summary=>"broken clouds", :temperature=>"70.99 F"},
     :total_books_found=>5,
     :books=>
      [{:isbn=>["9780762507849", "0762507845"],
        :title=>"Denver, Co",
        :publisher=>["Universal Map Enterprises"]},
       {:isbn=>["1427401683", "9781427401687"],
        :title=>"University of Denver Co 2007",
        :publisher=>["College Prowler"]},
       {:isbn=>["9780762557363", "0762557362"],
        :title=>"Denver Co Deluxe Flip Map",
        :publisher=>["Universal Map Enterprises"]},
       {:isbn=>["9780883183663", "0883183668"],
        :title=>"Photovoltaic safety, Denver, CO, 1988",
        :publisher=>["American Institute of Physics"]},
       {:isbn=>["9812582622", "9789812582621"],
        :title=>"Insight Fleximap Denver, CO (Insight Fleximaps)",
        :publisher=>["American Map Corporation"]}]}}}
```

<hr>

### User Registration
#### Request
```
POST /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```
#### 200 Response
```
{:data=>
  {:type=>"users",
   :id=>"867",
   :attributes=>{:email=>"whatever@example.com", :api_key=>"WIcWZskO4ZFxvrcQz9Sh2ZOMfjI"}}}
```
<hr>

### Login
#### Request
```
POST /api/v1/sessions
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password"
}
```
#### 200 Response
```
{:data=>
  {:type=>"users",
   :id=>"853",
   :attributes=>{:email=>"whatever@example.com", :api_key=>"k3d6U8Yb8530E35dbdkFF954Aaa"}}}
```

<hr>

### Road Trip
#### Request
```
POST /api/v1/road_trip
Content-Type: application/json
Accept: application/json

body:

{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```
#### 200 Response
```
{:data=>
  {:id=>nil,
   :type=>"roadtrip",
   :attributes=>
    {:start_city=>"New York,NY",
     :end_city=>"Los Angeles,CA",
     :travel_time=>"40 hour(s), 34 minute(s)",
     :weather_at_eta=>{:temperature=>69.78, :conditions=>"clear sky"}}}}
```
