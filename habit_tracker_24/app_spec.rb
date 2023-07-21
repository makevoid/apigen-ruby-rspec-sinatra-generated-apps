require 'rack/test'
require_relative './app'

describe 'Habit Tracker App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'should add a habit' do
    habit_name = 'Exercise'

    post '/habits', { name: habit_name }.to_json

    expect(last_response.status).to eq(201)

    habit = JSON.parse(last_response.body)
    expect(habit['name']).to eq(habit_name)
  end

  it 'should record habit completion' do
    habit_id = SecureRandom.uuid
    habit = { id: habit_id, name: 'Exercise', completions: [] }
    $habits << habit

    post "/habits/#{habit_id}/record"

    expect(last_response.status).to eq(201)

    recorded_habit = JSON.parse(last_response.body)
    expect(recorded_habit['id']).to eq(habit_id)
    expect(recorded_habit['completions']).to include(Date.today.to_s)
  end

  it 'should return habit statistics' do
    habit_id = SecureRandom.uuid
    completions = ['2022-01-01', '2022-01-02', '2022-01-03']
    habit = { id: habit_id, name: 'Exercise', completions: completions }
    $habits << habit

    get "/habits/#{habit_id}/stats"

    expect(last_response.status).to eq(200)

    stats = JSON.parse(last_response.body)
    expect(stats['total_completions']).to eq(completions.count)
    expect(stats['completion_rate']).to eq(completions.count.to_f / Date.today.yday)
  end
end