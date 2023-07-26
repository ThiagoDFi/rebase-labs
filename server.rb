require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require 'json'
require_relative 'database'
require_relative 'consult_exams'

before do
  response.headers['Access-Control-Allow-Origin'] = '*'
  response.headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS'
  response.headers['Access-Control-Allow-Headers'] = 'accept, authorization, origin, content-type'
end

options "*" do
  response.headers["Allow"] = "GET, POST, OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, Origin"
  response.headers["Access-Control-Allow-Origin"] = "*"
  200
end

consult_exams = ConsultExams.new

get '/tests' do
  consult_exams.consult
end

get '/hello' do
  'Hello world!'
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)