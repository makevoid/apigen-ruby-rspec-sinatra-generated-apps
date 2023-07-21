require 'sinatra'
require 'json'
require 'securerandom'
require 'date'

# In-memory storage for habits
$habits = []

# Endpoint to add a habit
post '/habits' do
  request_body = JSON.parse(request.body.read)
  habit_name = request_body['name']

  # Create a new habit with a unique ID
  habit = { id: SecureRandom.uuid, name: habit_name, completions: [] }

  # Add the habit to the in-memory storage
  $habits << habit

  # Return the added habit as JSON response
  status 201
  habit.to_json
end

# Endpoint to record habit completion
post '/habits/:id/record' do |habit_id|
  habit = $habits.find { |h| h[:id] == habit_id }

  # Return 404 if habit is not found
  halt 404, 'Habit not found' unless habit

  # Record the completion of the habit for the current date
  habit[:completions] << Date.today.to_s

  # Return the recorded habit as JSON response
  status 201
  habit.to_json
end

# Endpoint to view habit statistics
get '/habits/:id/stats' do |habit_id|
  habit = $habits.find { |h| h[:id] == habit_id }

  # Return 404 if habit is not found
  halt 404, 'Habit not found' unless habit

  # Calculate the total number of completions
  total_completions = habit[:completions].count

  # Calculate the completion rate
  completion_rate = total_completions.to_f / Date.today.yday

  # Build the statistics hash
  stats = { total_completions: total_completions, completion_rate: completion_rate }

  # Return the habit statistics as JSON response
  status 200
  stats.to_json
end