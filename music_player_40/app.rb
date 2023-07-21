require 'sinatra'
require 'json'
require 'dotenv/load'
require 'httparty'

configure do
  set :show_exceptions, false
end

before do
  @spotify_api_key = File.read(File.expand_path('~/.spotify_api_key')).strip
end

get '/search' do
  song_name = params['song_name']
  return { error: 'Please provide a song name' }.to_json if song_name.nil? || song_name.empty?

  search_url = "https://api.spotify.com/v1/search?q=#{song_name}&type=track"
  response = HTTParty.get(search_url, headers: { 'Authorization' => "Bearer #{@spotify_api_key}" })

  if response.code == 200
    tracks = response['tracks']['items'].map do |track|
      {
        track_id: track['id'],
        track_name: track['name'],
        artist_name: track['artists'].map { |artist| artist['name'] },
        album_name: track['album']['name']
      }
    end
    { tracks: tracks }.to_json
  else
    { error: 'Failed to retrieve tracks' }.to_json
  end
end

post '/play' do
  track_id = params['track_id']
  return { error: 'Please provide a track ID' }.to_json if track_id.nil? || track_id.empty?

  play_url = "https://api.spotify.com/v1/me/player/play"
  response = HTTParty.put(play_url, body: { uris: ["spotify:track:#{track_id}"] }.to_json, headers: { 'Authorization' => "Bearer #{@spotify_api_key}", 'Content-Type' => 'application/json' })

  if response.code == 204
    { message: 'Playback started' }.to_json
  else
    { error: 'Failed to start playback' }.to_json
  end
end

post '/pause' do
  pause_url = "https://api.spotify.com/v1/me/player/pause"
  response = HTTParty.put(pause_url, headers: { 'Authorization' => "Bearer #{@spotify_api_key}" })

  if response.code == 204
    { message: 'Playback paused' }.to_json
  else
    { error: 'Failed to pause playback' }.to_json
  end
end