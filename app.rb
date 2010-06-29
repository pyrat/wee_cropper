require 'sinatra'
require 'models/crop'
require 'sinatra/jsonp'

set :root, File.dirname(__FILE__)

# Make it jsonp but for now just make it HTTP
get '/crop' do
  
  [:crop_x, :crop_y, :crop_w, :crop_h, :image_location, :resize_info].each do |param|
    unless params[param]
      erb :error
    end
  end
  
  crop = Crop.new(params, settings.root)
  image_filename = crop.engage
  cropped_image = "http://" + request.host_with_port + "/images/cropped/" + image_filename
  
  data = [cropped_image]
  jsonp data
end

get '/' do
  erb :index
end