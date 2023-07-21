require_relative './app'
require 'rack/test'

RSpec.describe 'Music Player App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'returns a list of matching tracks when searching' do
    get '/search', song_name: 'Hello'
    expect(last_response).to be_ok
    puts "\nSearch Tracks:\n#{last_response.body[0..80]}\n---\n"
  end

  it 'starts playback of a given track' do
    post '/play', track_id: 'track_id_here'
    expect(last_response).to be_ok
    puts "\nPlayback Started:\n#{last_response.body[0..80]}\n---\n"
  end

  it 'pauses playback' do
    post '/pause'
    expect(last_response).to be_ok
    puts "\nPlayback Paused:\n#{last_response.body[0..80]}\n---\n"
  end

  it 'returns an error if no song name is provided' do
    get '/search'
    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body)).to eq({ "error" => "Please provide a song name" })
  end

  it 'returns an error if no track ID is provided' do
    post '/play'
    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body)).to eq({ "error" => "Please provide a track ID" })
  end

  it 'returns an error if failed to start playback' do
    post '/play', track_id: 'invalid_track_id'
    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body)).to eq({ "error" => "Failed to start playback" })
  end

  it 'returns an error if failed to pause playback' do
    post '/pause'
    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body)).to eq({ "error" => "Failed to pause playback" })
  end
end