# README

Welcome to Sweather Weather!

## Table of Contents
- [Technologies](#technologies)
- [System Dependencies](#system-dependencies)
- [Configuration](#configuration)
- [Database Creation](#database-creation)
- [How to Run the Test Suite](#how-to-run-the-test-suite)
<!-- - [Screenshots](#screenshots) -->
<!-- - [Additional Resources](#additional-resources) -->

## Technologies
|Development|Development|Testing
|--- |--- |--- |
|[Rails 5.2.6](https://rubygems.org/gems/rails/versions/5.2.6)|[Git](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)|[RSpec for Rails](https://github.com/rspec/rspec-rails)
|[Ruby 2.7.2](https://www.ruby-lang.org/en/downloads/)|[Github](https://desktop.github.com/)|[Capybara](https://github.com/teamcapybara/capybara)
|[Pry](https://rubygems.org/gems/pry/versions/0.10.3)|[FastJSONApi](https://github.com/Netflix/fast_jsonapi)|[Webmock](https://github.com/bblimke/webmock)
|[PostgresQL](https://www.postgresql.org/)|[BCrypt](https://github.com/bcrypt-ruby/bcrypt-ruby)|[VCR](https://github.com/vcr/vcr)
|[Faraday](https://github.com/lostisland/faraday)|[Rubocop](https://rubygems.org/gems/rubocop/versions/0.39.0)|[Launchy](https://rubygems.org/gems/launchy/versions/2.4.3)
|[Figaro](https://github.com/laserlemon/figaro)|[Atom](https://atom.io/)|[Postman](https://www.postman.com/product/rest-client/)
|||[SimpleCov](https://rubygems.org/gems/simplecov/versions/0.12.0)
|||[shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)|


## System Dependencies
- [MapQuest Developer API](https://developer.mapquest.com/documentation/)
  - [Sign up for an account with MapQuest](https://developer.mapquest.com/plan_purchase/steps/business_edition/business_edition_free/register)
  - Then, [get your key here](https://developer.mapquest.com/user/me/apps) then select "Create a New Key" and fill in required fields.
- [Open Weather Map API](https://openweathermap.org/api)
  - [Sign up](https://home.openweathermap.org/users/sign_up)
  - Go to [your API keys](https://home.openweathermap.org/api_keys), fill in API key name, and select "Generate."
- [Unsplash API ](https://unsplash.com/documentation)
  - First, login or [join](https://unsplash.com/join)
  - Then register your application. Go to [your apps](https://unsplash.com/oauth/applications), click "New Application, and fill in the required details.
  - NOTE: All applications must follow the [API Guidelines](https://help.unsplash.com/en/articles/2511245-unsplash-api-guidelines), including [properly providing attribution for the photographer and Unsplash](https://help.unsplash.com/en/articles/2511315-guideline-attribution).
- [Open Library API](https://openlibrary.org/dev/docs/api/search)
  - No authorization key required
  
## Configuration
  - Clone this repo
  - Run `bundle`

## Database Creation
  - Run `rails db:{create,migrate}`

## How to Run the Test Suite
### RSpec:
- Delete spec/fixtures/vcr_cassettes, then run `bundle exec rspec`
### Postman:
- In Terminal, run `rails s`
- In Postman, set appropriate HTTP verb, append endpoint URI to `http://localhost:3000/`, and select `SEND`.
- NOTE: Send a JSON payload in the body of the request in Postman. Under the address bar, click on `Body`, select `raw`, and from the dropdown that probably says `Text` in it, choose `JSON`.
