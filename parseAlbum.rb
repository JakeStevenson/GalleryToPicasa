#!/usr/bin/ruby

require "rubygems"
require "php_serialize"
require "go_picasa_go"
require "theuser.rb"
require "getFileAsString.rb"

class AlbumInfo
	@@user = Theuser.new
	@@existingAlbums = @@user.albums
	def initialize(galleryItem)
		@item = galleryItem
		@picasaID = findExistingID
	end
	def findExistingID
		@@existingAlbums.each do |album|
			if album.title == @item
				return album.id
			end
		end
		return nil
	end
	def rawPrint
		puts "."
		puts @picasaID
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

class AlbumParser
	def initialize(albumFile)
		toDeserialize = get_file_as_string(ARGV[0])
		out = PHP.unserialize(toDeserialize)

		out.each do |item|
			album = AlbumInfo.new(item)
			album.rawPrint
			puts "__________"
			#album.addtoPicasa
		end
	end
end



