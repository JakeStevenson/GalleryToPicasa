#!/usr/bin/ruby

require "rubygems"
require "php_serialize"
require "go_picasa_go"
require "theuser.rb"

def get_file_as_string(filename)
  data = ''
  f = File.open(filename, "r") 
  f.each_line do |line|
    data += line.gsub(";s:4:\"type\";", ";s:9:\"extension\";");
  end
  return data
end


class AlbumInfo
	@@user = Theuser.new
	@@existingAlbums = @@user.albums
	def initialize(galleryItem)
		@item = galleryItem
		@picasaID = findExistingID
	end
	def findExistingID
		@@existingAlbums.each do |album|
			if album.title = @item
				return album.id
			end
		end
	end
	def rawPrint
		puts "."
		puts @picasaID
		puts @item
	end
	def print
		puts "_____________________________"
	end
	def addtoPicasa
		picasaAlbum = Picasa::DefaultAlbum.new
		picasaAlbum.user = @@user
		picasaAlbum.title = @item
		picasaAlbum.access = 'private'
		picasaAlbum.picasa_save!
	end
	def getPhotos
	end


end

toDeserialize = get_file_as_string(ARGV[0])
out = PHP.unserialize(toDeserialize)

out.each do |item|
	album = AlbumInfo.new(item)
	album.rawPrint
	puts "__________"
	#album.rawPrint
#	album.addtoPicasa
end



