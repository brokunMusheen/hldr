class Giffer

  def self.transform gif_url, size = {}

    destination = '/tmp/min.gif'

    copy = MiniMagick::Image.open gif_url

    gif = MiniMagick::Tool::Convert.new do |img|
      img << copy.path
      img.coalesce
      img.gravity 'center'
      img.resize "#{size[:width] || 50}x#{size[:height] || 50}^"
      img.crop "#{size[:width] || 50}x#{size[:height] || 50}+0+0"
      img.repage.+
      img << destination
    end

    MiniMagick::Image.open(destination).to_blob

  end

end