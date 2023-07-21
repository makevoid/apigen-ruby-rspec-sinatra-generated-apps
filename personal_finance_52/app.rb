require 'sinatra'
require 'json'

# In-memory storage for transactions
$transactions = []

# Endpoint to add income or expense transactions
post '/transactions' do
  request_body = JSON.parse(request.body.read)
  $transactions << request_body
  status 201
end

# Endpoint to list all transactions
get '/transactions' do
  content_type :json
  $transactions.to_json
end

# Endpoint to provide a summary of total income, total expenses, and balance
get '/summary' do
  total_income = 0
  total_expenses = 0

  $transactions.each do |transaction|
    if transaction['type'] == 'income'
      total_income += transaction['amount']
    elsif transaction['type'] == 'expense'
      total_expenses += transaction['amount']
    end
  end

  balance = total_income - total_expenses

  {
    total_income: total_income,
    total_expenses: total_expenses,
    balance: balance
  }.to_json
end