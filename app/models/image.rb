require 'mini_magick'

class Image < ApplicationRecord
  has_one_attached :image_file

  def convert_to_svg
    return unless image_file.attached?

      unless image_file.content_type == 'image/svg+xml'
       image_data = Tempfile.new(['input_image', '.jpg'])
      image_data.binmode
      image_data.write(image_file.download)
      image_data.close

        converted_image = MiniMagick::Tool::Convert.new do |convert|
        convert << image_data.path 
        convert << "svg:-"        
      end

       svg_file = StringIO.new(converted_image)
      svg_file.class.send(:attr_accessor, :content_type, :original_filename)
      svg_file.content_type = 'image/svg+xml'
      svg_file.original_filename = "#{image_file.filename.base}.svg"

      image_file.purge 
      image_file.attach(io: svg_file, filename: svg_file.original_filename)

   
      image_data.unlink
    end
  end
end
