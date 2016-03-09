# module CarrierWave
#   module FFMPEG
#     module ClassMethods
#       def encode_video(target_format)
#         process encode_video: [target_format]
#       end
#     end

#     def encode_video(format)
#       directory = File.dirname(current_path)
#       tmpfile = File.join(directory, 'tmpfile')
#       File.rename(current_path, tmpfile)

#       file = ::FFMPEG::Movie.new(tmpfile)
#       new_name = File.basename(current_path, '.*') + '.' + format.to_s
#       current_extention = File.extname(current_path).gsub('.', '')
#       encoded_file = File.join(directory, new_name)

#       file.transcode(encoded_file)

#       self.filename[-current_extention.size..-1] = format.to_s
#       self.file.file[-current_extention.size..-1] = format.to_s

#       File.delete(tmpfile)
#     end
#   end
# end
