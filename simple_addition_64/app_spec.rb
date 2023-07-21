require_relative './app'
require 'rack/test'

describe MathApp do
  include Rack::Test::Methods

  def app
    MathApp
  end

  it "returns the sum of two numbers" do
    get '/sum/2/3'
    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body)).to eq({ "result" => 5 })
  end

  it "returns the sum of negative numbers" do
    get '/sum/-5/10'
    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body)).to eq({ "result" => 5 })
  end

  it "returns the sum of zero and a number" do
    get '/sum/0/7'
    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body)).to eq({ "result" => 7 })
  end

  it "returns the sum of large numbers" do
    get '/sum/1000000/2000000'
    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body)).to eq({ "result" => 3000000 })
  end

  it "returns the sum of decimal numbers" do
    get '/sum/1.5/2.5'
    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body)).to eq({ "result" => 4.0 })
  end

  it "returns the difference of two numbers" do
    get '/subtract/5/3'
    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body)).to eq({ "result" => 2 })
  end

  it "returns the product of two numbers" do
    get '/multiply/4/5'
    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body)).to eq({ "result" => 20 })
  end

  it "returns the quotient of two numbers" do
    get '/divide/10/2'
    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body)).to eq({ "result" => 5 })
  end
end