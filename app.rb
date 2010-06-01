require 'sinatra'
require 'sinatra/jsonp'

post '/crop' do
  crop = Crop.new(params[:image])
  jsonp crop
end

get '/' do
  haml :index
end