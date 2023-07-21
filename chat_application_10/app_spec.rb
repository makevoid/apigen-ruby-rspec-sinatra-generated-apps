require_relative './app'
require 'rack/test'

describe 'Chat Application' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'should send a message' do
    post '/messages', { message: 'Hello, World!' }.to_json
    expect(last_response.status).to eq(201)
    puts "\nSend Message\n#{last_response.body[0..80]}\n---\n"
  end

  it 'should receive messages' do
    get '/messages'
    expect(last_response.status).to eq(200)
    puts "\nReceive Messages\n#{last_response.body[0..80]}\n---\n"
  end

  it 'should list all messages' do
    get '/messages/list'
    expect(last_response.status).to eq(200)
    puts "\nList Messages\n#{last_response.body[0..80]}\n---\n"
  end

  it 'should return an error if message is empty' do
    post '/messages', { message: '' }.to_json
    expect(last_response.status).to eq(400)
    expect(JSON.parse(last_response.body)).to eq({ 'error' => 'Message cannot be empty' })
    puts "\nEmpty Message Error\n#{last_response.body[0..80]}\n---\n"
  end

  it 'should return the correct list of messages' do
    $messages = ['Hello', 'World', 'Test']
    get '/messages/list'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq("1. Hello\n2. World\n3. Test")
    puts "\nList Messages\n#{last_response.body[0..80]}\n---\n"
  end
end