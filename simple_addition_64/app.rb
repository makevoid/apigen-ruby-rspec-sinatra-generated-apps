require 'sinatra'
require 'json'

class MathApp < Sinatra::Base
  before do
    content_type :json
  end

  get '/sum/:num1/:num2' do
    num1 = params[:num1].to_f
    num2 = params[:num2].to_f
    sum = num1 + num2
    { result: sum }.to_json
  end

  get '/subtract/:num1/:num2' do
    num1 = params[:num1].to_i
    num2 = params[:num2].to_i
    difference = num1 - num2
    { result: difference }.to_json
  end

  get '/multiply/:num1/:num2' do
    num1 = params[:num1].to_i
    num2 = params[:num2].to_i
    product = num1 * num2
    { result: product }.to_json
  end

  get '/divide/:num1/:num2' do
    num1 = params[:num1].to_i
    num2 = params[:num2].to_i
    quotient = num1 / num2
    { result: quotient }.to_json
  end
end