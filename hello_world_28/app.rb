require 'sinatra'

class HelloWorldApp < Sinatra::Base
  get '/' do
    'Hello World!'
  end

  post '/' do
    'Hello World!'
  end

  put '/' do
    'Hello World!'
  end

  delete '/' do
    'Hello World!'
  end
end