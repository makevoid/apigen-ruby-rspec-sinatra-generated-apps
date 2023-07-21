require 'sinatra'
require 'json'

# Global array to store notes
NOTES = []

# Endpoint to list all notes
get '/notes' do
  content_type :json
  NOTES.to_json
end

# Endpoint to create a new note
post '/notes' do
  content_type :json
  data = JSON.parse(request.body.read)
  note = { title: data['title'], content: data['content'] }
  NOTES << note
  status 201
  note.to_json
end

# Endpoint to show a specific note
get '/notes/:id' do |id|
  content_type :json
  note = NOTES[id.to_i]
  if note
    note.to_json
  else
    status 404
    { error: 'Note not found' }.to_json
  end
end

# Endpoint to update a note
put '/notes/:id' do |id|
  content_type :json
  note = NOTES[id.to_i]
  if note
    data = JSON.parse(request.body.read)
    note[:title] = data['title']
    note[:content] = data['content']
    note.to_json
  else
    status 404
    { error: 'Note not found' }.to_json
  end
end

# Endpoint to delete a note
delete '/notes/:id' do |id|
  note = NOTES[id.to_i]
  if note
    NOTES.delete(note)
    status 204
  else
    status 404
    { error: 'Note not found' }.to_json
  end
end

# app_spec.rb

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