require 'json'
require 'pathname'
require 'fileutils'
#TARGET_PATH = "~/app/radiko/public/mp3/"
TARGET_PATH = "./mp3/"

Dir.glob("original/*.info.json").each do |file|
  json = JSON.parse(File.read(file))

  original_title = Pathname.new(json['_filename'])
  audio_filename = original_title.to_s.
    gsub(original_title.extname, '.mp3')

  unless File.exists?(audio_filename)
    raise "do not found: #{json['title']}"
  end

  # ファイル名をタイトルにする
  renamed_filename = "#{json['title'].gsub("/", "_")}.mp3"
  dest_path = "#{TARGET_PATH}#{renamed_filename}"
  FileUtils.cp audio_filename, dest_path

  # 更新日を変更する
  upload_date = audio_filename.split("-")[0].split('/')[1]

  _, year, month, day = upload_date.split(/([0-9]{4})(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])/)
  # 適当にアップロード時間は深夜1時とする
  mtime = Time.new(year, month, day ,1, 0)
  File.utime(mtime, mtime, dest_path)
end
