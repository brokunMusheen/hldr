require 'sinatra/base'

module Sinatra
  module HtmlHelper

    def style_tag style_name
      "<link rel=\"stylesheet\" href=\"/#{style_name}.css\" />"
    end

    def image_tag image_name
      "<img src=\"#{ image_name }\">"
    end

  end

  helpers HtmlHelper
end
