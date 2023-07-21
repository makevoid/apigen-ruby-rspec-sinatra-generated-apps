require_relative './app'
require 'rack/test'

describe 'Calendar App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before do
    $events = []
  end

  it 'adds an event' do
    post '/events', { title: 'Meeting', date: '2022-01-01' }.to_json
    expect(last_response.status).to eq(201)
    expect(JSON.parse(last_response.body)).to include({
      'title' => 'Meeting',
      'date' => '2022-01-01'
    })
    puts "\nadds an event\n#{last_response.body[0..80]}\n---\n"
  end

  it 'lists all events' do
    event_id = '12345'
    $events << { id: event_id, title: 'Meeting', date: '2022-01-01' }

    get '/events'

    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body)).to include({
      'id' => event_id,
      'title' => 'Meeting',
      'date' => '2022-01-01'
    })
    puts "\nlists all events\n#{last_response.body[0..80]}\n---\n"
  end

  it 'removes an event' do
    event_id = '12345'
    $events << { id: event_id, title: 'Meeting', date: '2022-01-01' }

    delete "/events/#{event_id}"

    expect(last_response.status).to eq(204)
    expect($events).to be_empty
    puts "\nremoves an event\n#{last_response.body[0..80]}\n---\n"
  end

  it 'updates an event' do
    event_id = '12345'
    $events << { id: event_id, title: 'Meeting', date: '2022-01-01' }

    put "/events/#{event_id}", { title: 'Updated Meeting', date: '2022-01-02' }.to_json

    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body)).to include({
      'id' => event_id,
      'title' => 'Updated Meeting',
      'date' => '2022-01-02'
    })
    puts "\nupdates an event\n#{last_response.body[0..80]}\n---\n"
  end
end