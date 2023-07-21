require 'sinatra'
require 'json'
require 'net/http'

class CurrencyConverterApp < Sinatra::Base
  configure do
    set :show_exceptions, false
  end

  get '/convert' do
    from_currency = params['from']
    to_currency = params['to']
    amount = params['amount'].to_f

    exchange_rate_api_key = File.read(File.expand_path('~/.exchangerate_api_key')).strip
    exchange_rate_api_url = "https://v6.exchangerate-api.com/v6/#{exchange_rate_api_key}/latest/USD"

    uri = URI(exchange_rate_api_url)
    response = Net::HTTP.get(uri)
    exchange_rates = JSON.parse(response)['conversion_rates']

    if exchange_rates.key?(from_currency) && exchange_rates.key?(to_currency)
      converted_amount = amount * (exchange_rates[to_currency] / exchange_rates[from_currency])
      { from: from_currency, to: to_currency, amount: amount, converted_amount: converted_amount }.to_json
    else
      status 400
      { error: 'Invalid currency' }.to_json
    end
  end

  post '/convert' do
    from_currency = params['from']
    to_currency = params['to']
    amount = params['amount'].to_f

    exchange_rate_api_key = File.read(File.expand_path('~/.exchangerate_api_key')).strip
    exchange_rate_api_url = "https://v6.exchangerate-api.com/v6/#{exchange_rate_api_key}/latest/USD"

    uri = URI(exchange_rate_api_url)
    response = Net::HTTP.get(uri)
    exchange_rates = JSON.parse(response)['conversion_rates']

    if exchange_rates.key?(from_currency) && exchange_rates.key?(to_currency)
      converted_amount = amount * (exchange_rates[to_currency] / exchange_rates[from_currency])
      { from: from_currency, to: to_currency, amount: amount, converted_amount: converted_amount }.to_json
    else
      status 400
      { error: 'Invalid currency' }.to_json
    end
  end
end