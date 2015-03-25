require 'sinatra'
require 'mini_magick'

get '/' do
		'Hello, yuns.'
end

get '/gif/*' do |gif_name|
		#http://gph.to/1HCPQwE
		url = "http://media.giphy.com/media/#{gif_name}/giphy.gif"

		size = Hash.new
		size[:width] = params[:width] || 50
		size[:height] = params[:height] || 50

		"<img src='#{transform url, size}'>"
end

get '/*.gif' do |gif_name|
		File.read("#{gif_name}.gif")
end

def transform gif_url, size = {}
		img = MiniMagick::Image.open gif_url
		img.coalesce
		img.resize "#{size[:width] || 50}x#{size[:height] || 50}"
#		img.layers 'Optimize'
		img.write "./min.gif"

		"/min.gif"
end
