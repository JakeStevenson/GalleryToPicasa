#!/usr/bin/ruby

require "rubygems"
require "php_serialize"

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

class PhotoParser
	def initialize(photosDat)
		@toDeserialize = get_file_as_string(photosDat)
	end
	def parse()
		out = PHP.unserialize(@toDeserialize)

		out.each do |item|
			photo = PhotoInfo.new(item)
			photo.print
			photo.rawPrint
		end
	end
end


