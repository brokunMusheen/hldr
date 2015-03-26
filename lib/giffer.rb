class Giffer

  def self.transform gif_url, size = {}
    img = MiniMagick::Image.open gif_url
    img.coalesce
    img.resize "#{size[:width] || 50}x#{size[:height] || 50}"
    #img.extent "#{size[:width] || 50}x#{size[:height] || 50}"
    img.write "/tmp/min.gif"

    "/tmp/min.gif"
  end

end