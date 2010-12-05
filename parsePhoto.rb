#!/usr/bin/ruby

require "rubygems"
require "php_serialize"

def get_file_as_string(filename)
  data = ''
  f = File.open(filename, "r") 
  f.each_line do |line|
    data += line.gsub(";s:4:\"type\";", ";s:9:\"extension\";");
  end
  return data
end

class PhotoInfo
	def initialize(galleryItem)
		@item = galleryItem
		@caption = galleryItem.caption
		@image = galleryItem.image.name
		@extension = galleryItem.image.extension
	end
	def rawPrint
		puts "."
		puts @item
	end
	def print
		puts "_____________________________"
		puts @caption
		puts @image 
		puts @extension
	end
end

toDeserialize = get_file_as_string(ARGV[0])
out = PHP.unserialize(toDeserialize)

out.each do |item|
	photo = PhotoInfo.new(item)
	photo.print
	photo.rawPrint
end



