# encoding: utf-8

class AssetItemUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:

  # include CarrierWave::FFMPEG
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  include CarrierWave::Video
  include CarrierWave::Video::Thumbnailer
  

  # Choose what kind of storage to use for this uploader:
  storage :file
  #storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb, :if => :image? do
    process :resize_to_fill => [258, 175]
  end

  version :preview, :if => :image? do
    process :resize_to_fit => [500, 500]
  end

  version :full, :if => :image? do
    process :resize_to_fit => [800, 800]
  end

    
  # version :mp4, :if => :video? do
  #   process encode_video: [:mp4, audio_codec: "aac", :custom => "-strict experimental -q:v 5 -preset slow -g 30"]
  #   def full_filename(for_file)
  #     super.chomp(File.extname(super)) + '.mp4'
  #   end
  # end

  # Removed temporarily as webm transcoding is too slow.
  # 
  # version :webm, :if => :video? do
  #   process :encode_video => [:webm, audio_codec: "aac", :custom => "-strict experimental -q:v 5 -preset slow -g 30"]
  #   def full_filename(for_file)
  #     "#{File.basename(for_file, File.extname(for_file))}.webm"
  #   end
  # end

  version :video_thumbnail do
    process thumbnail: [{format: 'png', size: 258 }]
    def full_filename for_file
      png_name for_file, version_name
    end
  end

  def png_name for_file, version_name
    %Q{#{version_name}_#{for_file.chomp(File.extname(for_file))}.png}
  end



  # version :webm do
  #   process encode_video: [:webm]
  # end
  
  # version :flv do
  #   process encode_video: [:flv]
  # end


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list

    # TODO: Use a conditional for whitelisting:
    #if category type is image:
      # %w(jpg jpeg gif png pdf)
    # elsif category type is video:
      # %w(mp4 flv webm)
    # elsif category type is docs:
      # %w(pdf docx)

    %w(jpg jpeg gif png pdf mov mp3 mp4 webm avi)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  protected

  def image?(new_file)
    new_file.content_type.start_with? 'image'
  end

  def video?(new_file)
    new_file.content_type.start_with? 'video'
  end

  def audio?(new_file)
    new_file.content_type.start_with? 'audio'
  end
end
