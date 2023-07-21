require 'sinatra'
require 'json'
require 'securerandom'

# In-memory storage for events
$events = []

# Endpoint to add events
post '/events' do
  request_body = JSON.parse(request.body.read)
  event = {
    id: SecureRandom.uuid,
    title: request_body['title'],
    date: request_body['date']
  }
  $events << event
  status 201
  event.to_json
end

# Endpoint to list all events
get '/events' do
  $events.to_json
end

# Endpoint to remove events
delete '/events/:id' do |id|
  event = $events.find { |e| e[:id] == id }
  if event
    $events.delete(event)
    status 204
  else
    status 404
  end
end

# Endpoint to update events
put '/events/:id' do |id|
  event = $events.find { |e| e[:id] == id }
  if event
    request_body = JSON.parse(request.body.read)
    event[:title] = request_body['title']
    event[:date] = request_body['date']
    status 200
    event.to_json
  else
    status 404
  end
end