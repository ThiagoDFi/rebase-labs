require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require 'json'
require_relative 'database'
require_relative 'consult_exams'

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