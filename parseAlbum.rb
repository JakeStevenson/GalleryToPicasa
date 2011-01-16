#!/usr/bin/ruby

require "rubygems"
require "php_serialize"
require "go_picasa_go"
require "theuser.rb"
require "getFileAsString.rb"
require "parsePhoto.rb"

class AlbumInfo
	attr_accessor :picasaAlbum
	@@user = Theuser.new
	def initialize(galleryItem)
		@item = galleryItem
		@title = galleryItem.fields["name"]
	end
	def addtoPicasa
		@picasaAlbum = Picasa::DefaultAlbum.new
		@picasaAlbum.user = @@user
		@picasaAlbum.title = @title
		@picasaAlbum.access = 'private'
		@picasaAlbum.picasa_save!
	end
	def getfromPicasa
		allAlbums = @@user.albums 
		puts @title
		@picasaAlbum = allAlbums.find {|a| a.title = @title}
		puts "Found " + @picasaAlbum.title
	end

end

class AlbumParser
	def initialize(albumFolder, albumFile)
		@folder = albumFolder
		toDeserialize = get_file_as_string(albumFile)
		out = PHP.unserialize(toDeserialize)
		album = AlbumInfo.new(out)
		if(!File.exist?(@folder + 'photosDone.txt'))
			puts("Already processed this album once")
			album.addtoPicasa
		else
			album.getfromPicasa
		end
		processor = PhotoParser.new(album.picasaAlbum, @folder)
		open('albumsDone.txt', 'w'){|f|
			f.puts(albumFile)
		}
	end

end



