require_relative './app'
require 'rack/test'
require 'rspec'

RSpec.describe App do
  include Rack::Test::Methods

  def app
    App
  end

  it "returns the astronomy picture of the day along with its description" do
    get '/apod'
    expect(last_response).to be_ok
    expect(last_response.body).to include('title')
    expect(last_response.body).to include('explanation')
    puts "\nreturns the astronomy picture of the day along with its description\n#{last_response.body[0..80]}\n---\n"
  end

  it "returns the astronomy picture of the day with a valid API key" do
    api_key = File.read(File.expand_path('~/.nasa_api_key')).strip
    expect(api_key).not_to be_empty
  end

  it "returns the URL of the astronomy picture of the day" do
    get '/apod/image_url'
    expect(last_response).to be_ok
    expect(last_response.body).to include('url')
    puts "\nreturns the URL of the astronomy picture of the day\n#{last_response.body[0..80]}\n---\n"
  end

  it "returns the astronomy picture of the day for a specific date" do
    date = '2022-01-01'
    get "/apod/date/#{date}"
    expect(last_response).to be_ok
    expect(last_response.body).to include('title')
    expect(last_response.body).to include('explanation')
    puts "\nreturns the astronomy picture of the day for a specific date\n#{last_response.body[0..80]}\n---\n"
  end
end