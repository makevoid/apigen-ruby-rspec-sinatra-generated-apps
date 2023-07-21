require_relative './app'
require 'rack/test'

describe 'Note Taking App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'lists all notes' do
    get '/notes'
    expect(last_response).to be_ok
    puts "\nList Notes\n#{last_response.body[0..80]}\n---\n"
  end

  it 'creates a new note' do
    post '/notes', { title: 'Note 1', content: 'Content 1' }.to_json
    expect(last_response).to be_created
    puts "\nCreate Note\n#{last_response.body[0..80]}\n---\n"
  end

  it 'shows a specific note' do
    get '/notes/0'
    expect(last_response).to be_ok
    puts "\nShow Note\n#{last_response.body[0..80]}\n---\n"
  end

  it 'updates a note' do
    put '/notes/0', { title: 'Updated Note', content: 'Updated Content' }.to_json
    expect(last_response).to be_ok
    puts "\nUpdate Note\n#{last_response.body[0..80]}\n---\n"
  end

  it 'deletes a note' do
    delete '/notes/0'
    expect(last_response).to be_no_content
    puts "\nDelete Note\n---\n"
  end
end