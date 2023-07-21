require 'sinatra'
require 'json'

# In-memory storage for messages
$messages = []

# Endpoint to send a message
post '/messages' do
  request_body = JSON.parse(request.body.read)
  message = request_body['message']
  
  if message.nil? || message.empty?
    status 400
    return { error: 'Message cannot be empty' }.to_json
  end
  
  $messages << message
  status 201
end

# Endpoint to receive messages
get '/messages' do
  $messages.to_json
end

# Endpoint to list all messages
get '/messages/list' do
  $messages.each_with_index.map { |message, index| "#{index + 1}. #{message}" }.join("\n")
end