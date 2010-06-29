$:.unshift File.join(File.dirname(__FILE__), '..')

require 'rubygems'

require 'app'
require 'spec'
require 'rack/test'

set :environment, :test

describe "Wee Cropper" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "should not accept incomplete parameters" do
    get "/crop"
    # last_response.should be_error
    last_response.body.should =~ /error/
  end

  it "should show the index page ok" do
    get "/"
    last_response.should be_ok
  end

end
