require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require 'json'
require_relative 'database'
require_relative 'consult_exams'

consult_exams = ConsultExams.new

get '/' do
  File.read(File.join('index.html'))
end

get '/tests' do
  consult_exams.consult
end

get '/tests/:token' do
    result = Database.execute("SELECT * FROM exams WHERE token_resultado_exame = '#{params['token']}'").entries
    consult_exams.layout(result)
end


Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)