require 'rack/test'
require_relative './app'

RSpec.describe CurrencyConverterApp do
  include Rack::Test::Methods

  def app
    CurrencyConverterApp
  end

  describe 'GET /convert' do
    it 'returns the converted amount in the target currency' do
      get '/convert', from: 'USD', to: 'EUR', amount: 100

      expect(last_response.status).to eq(200)
      expect(last_response.body).to include('from', 'to', 'amount', 'converted_amount')
    end

    it 'returns an error for invalid currency' do
      get '/convert', from: 'USD', to: 'XYZ', amount: 100

      expect(last_response.status).to eq(400)
      expect(last_response.body).to include('error')
    end
  end

  describe 'POST /convert' do
    it 'returns the converted amount in the target currency' do
      post '/convert', from: 'USD', to: 'EUR', amount: 100

      expect(last_response.status).to eq(200)
      expect(last_response.body).to include('from', 'to', 'amount', 'converted_amount')
    end

    it 'returns an error for invalid currency' do
      post '/convert', from: 'USD', to: 'XYZ', amount: 100

      expect(last_response.status).to eq(400)
      expect(last_response.body).to include('error')
    end
  end
end