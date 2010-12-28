#!/usr/bin/ruby

require "rubygems"
require "php_serialize"
require "go_picasa_go"
require "theuser.rb"
require "getFileAsString.rb"
require "parsePhoto.rb"

class AlbumInfo
	@@user = Theuser.new
	@@existingAlbums = @@user.albums
	def initialize(galleryItem)
		@item = galleryItem
		@title = galleryItem.fields["name"]
	end
	def rawPrint
		puts "."
		puts @item
		puts @title
	end
	def print
		puts "_____________________________"
	end
	def addtoPicasa
		picasaAlbum = Picasa::DefaultAlbum.new
		picasaAlbum.user = @@user
		picasaAlbum.title = @title
		picasaAlbum.access = 'private'
		picasaAlbum.picasa_save!
	end

end

class AlbumParser
	def initialize(albumFolder, albumFile)
		@folder = albumFolder
		puts albumFile
		toDeserialize = get_file_as_string(albumFile)
		out = PHP.unserialize(toDeserialize)
		album = AlbumInfo.new(out)
		#album.rawPrint
		#album.addtoPicasa
		processPhotos
	end

	def processPhotos
		processor = PhotoParser.new(@folder+'photos.dat')
	end
end



