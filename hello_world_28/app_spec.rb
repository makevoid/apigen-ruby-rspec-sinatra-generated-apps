require_relative './app'
require 'rack/test'

RSpec.describe HelloWorldApp do
  include Rack::Test::Methods

  def app
    HelloWorldApp
  end

  it "returns 'Hello World!' when accessing the root endpoint" do
    get '/'
    expect(last_response.body).to eq('Hello World!')
  end

  it "returns 'Hello World!' when accessing the root endpoint with GET method" do
    get '/'
    expect(last_response.body).to eq('Hello World!')
  end

  it "returns 'Hello World!' when accessing the root endpoint with POST method" do
    post '/'
    expect(last_response.body).to eq('Hello World!')
  end

  it "returns 'Hello World!' when accessing the root endpoint with PUT method" do
    put '/'
    expect(last_response.body).to eq('Hello World!')
  end

  it "returns 'Hello World!' when accessing the root endpoint with DELETE method" do
    delete '/'
    expect(last_response.body).to eq('Hello World!')
  end
end