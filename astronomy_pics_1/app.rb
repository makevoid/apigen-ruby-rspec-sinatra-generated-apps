require 'sinatra'
require 'json'
require 'net/http'

class App < Sinatra::Base
  configure do
    set :show_exceptions, false
  end

  get '/apod' do
    api_key = File.read(File.expand_path('~/.nasa_api_key')).strip
    uri = URI("https://api.nasa.gov/planetary/apod?api_key=#{api_key}")
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    {
      title: data['title'],
      explanation: data['explanation']
    }.to_json
  end

  get '/apod/image_url' do
    api_key = File.read(File.expand_path('~/.nasa_api_key')).strip
    uri = URI("https://api.nasa.gov/planetary/apod?api_key=#{api_key}")
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    {
      url: data['url']
    }.to_json
  end

  get '/apod/date/:date' do
    api_key = File.read(File.expand_path('~/.nasa_api_key')).strip
    date = params[:date]
    uri = URI("https://api.nasa.gov/planetary/apod?api_key=#{api_key}&date=#{date}")
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    {
      title: data['title'],
      explanation: data['explanation']
    }.to_json
  end
end