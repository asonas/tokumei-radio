require 'json'
require 'pathname'
require 'fileutils'

Dir.glob("original/*.info.json").each do |file|
  json = JSON.parse(File.read(file))
  original_filename = Pathname.new json['_filename']
  filename = if File.exists? original_filename
    original_filename
  else
    if File.exists? original_filename.to_s.gsub(original_filename.extname, '.mkv')
      original_filename.sub(original_filename.extname, '.mkv')
    else
      raise 'nai'
    end
  end

  output_filename = filename.sub(filename.extname, '.mp3')
  unless File.exists? output_filename
    system "/usr/local/ffmpeg_build/bin/ffmpeg -i #{filename.to_s} -vn -ac 2 -ar 44100 -ab 192k -acodec libmp3lame -f mp3 #{output_filename}"
  end
end
