class Giffer

  def self.transform gif_url, size = {}

    destination = '/tmp/min.gif'

    copy = MiniMagick::Image.open gif_url

    copy.combine_options do |img|
      img.coalesce
      img.gravity 'center'
      img.resize "#{size[:width] || 50}x#{size[:height] || 50}^"
      img.crop "#{size[:width] || 50}x#{size[:height] || 50}+0+0"
      img.repage.+
      # img << destination
    end.to_blob

  end

end