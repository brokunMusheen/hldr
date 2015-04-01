require 'sinatra'
require 'mini_magick'
require 'tilt/sass'

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

get '/gif/*/*/*' do |gif_name, width, height|
  #http://gph.to/1HCPQwE
  url = "http://media.giphy.com/media/#{gif_name}/giphy.gif"

  size = Hash.new
  size[:width] = width || 100
  size[:height] = height || 100

  content_type 'image/gif'
  Giffer::transform url, size

end

get '/tmp/*.gif' do |gif_name|
  File.read "/tmp/#{gif_name}.gif"
end

# Stylesheet route
get '/*.css' do |styles|
  scss "../assets/stylesheets/#{styles}".to_sym, style: :expanded
end

