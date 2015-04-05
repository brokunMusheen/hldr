require 'sinatra'
require 'mini_magick'
require 'tilt/sass'
require_relative 'lib/giphy_api'

# Include view helpers
require_relative 'views/helpers/html'


# Include application libraries
require_relative 'lib/giffer'


Tilt.register Tilt::ERBTemplate, 'html.erb'


#
# Routes
#

get '/' do
  erb :page_home, layout: :main, layout_options: { views: 'views/layouts' }
end

get '/alpha' do
  erb :page_alpha, layout: :main, layout_options: { views: 'views/layouts' }
end

get %r{([\d]+)x([\d]+)} do |width, height|

  query = params[:q].split.join('+') || "random"

  size = Hash.new
  size[:width] = width
  size[:height] = height

  api = GiphyApi.new
  result_url = api.search query

  #send_file open(result), type: :gif, disposition: 'inline'
  content_type 'image/gif'
  Giffer::transform result_url, size
end

get '/tmp/*.gif' do |gif_name|
  File.read "/tmp/#{gif_name}.gif"
end

# Stylesheet route
get '/*.css' do |styles|
  scss "../assets/stylesheets/#{styles}".to_sym, style: :expanded
end

