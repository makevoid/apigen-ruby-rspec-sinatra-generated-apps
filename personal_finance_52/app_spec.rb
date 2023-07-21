require_relative './app'
require 'rack/test'

describe 'Personal Finance Tracker App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'adds a transaction' do
    post '/transactions', { type: 'income', amount: 100 }.to_json
    expect(last_response.status).to eq(201)
    puts "\nadds a transaction\n#{last_response.body[0..80]}\n---\n"
  end

  it 'lists all transactions' do
    get '/transactions'
    expect(last_response.status).to eq(200)
    puts "\nlists all transactions\n#{last_response.body[0..80]}\n---\n"
  end

  it 'provides a summary' do
    post '/transactions', { type: 'income', amount: 100 }.to_json
    post '/transactions', { type: 'expense', amount: 50 }.to_json

    get '/summary'
    expect(last_response.status).to eq(200)
    puts "\nprovides a summary\n#{last_response.body[0..80]}\n---\n"
  end

  it 'adds an income transaction' do
    post '/transactions', { type: 'income', amount: 200 }.to_json
    expect(last_response.status).to eq(201)
    puts "\nadds an income transaction\n#{last_response.body[0..80]}\n---\n"
  end

  it 'adds an expense transaction' do
    post '/transactions', { type: 'expense', amount: 50 }.to_json
    expect(last_response.status).to eq(201)
    puts "\nadds an expense transaction\n#{last_response.body[0..80]}\n---\n"
  end

  it 'lists all transactions' do
    get '/transactions'
    expect(last_response.status).to eq(200)
    puts "\nlists all transactions\n#{last_response.body[0..80]}\n---\n"
  end

  it 'provides a summary' do
    post '/transactions', { type: 'income', amount: 100 }.to_json
    post '/transactions', { type: 'expense', amount: 50 }.to_json

    get '/summary'
    expect(last_response.status).to eq(200)
    puts "\nprovides a summary\n#{last_response.body[0..80]}\n---\n"
  end
end