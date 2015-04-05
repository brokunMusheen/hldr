require 'json'
require 'net/http'

class GiphyApi

  @@api_key = 'dc6zaTOxFJmzC'
  @@size_limit = 500000 # 500KB

  @@randoms = [
      'bulTMUXeQ36YU'
  ]

  def search query
    uri = "http://api.giphy.com/v1/gifs/search?q=#{query}&api_key=#{@@api_key}"

    resp = Net::HTTP.get(URI.parse(uri))

    resp_obj = JSON.parse resp

    result_gif = resp_obj['data'].detect do |gif|
      gif['images']['downsized']['size'].to_i <= @@size_limit
    end

    if result_gif.nil?
      resp = Net::HTTP.get(URI.parse("http://api.giphy.com/v1/gifs/#{@@randoms.sample}?api_key=#{@@api_key}"))

      result_gif = (JSON.parse resp)['data']
    end

    result_gif['images']['downsized']['url']
  end

end