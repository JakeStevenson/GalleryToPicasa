#!/usr/bin/ruby

require "rubygems"
require "php_serialize"
require "theuser.rb"

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
	def initialize(album, folder)
		@album = album
		@folder = folder
		@toDeserialize = get_file_as_string(folder+'photos.dat')
		begin
			f = open(@folder+'photosDone.txt', 'r') 
			@existing = f.readlines().map(&:chomp)
			puts('opened previous list')
		rescue
			@existing = Array.new
		end
		parse
	end
	def parse()
		out = PHP.unserialize(@toDeserialize)

		out.each do |item|
			if item.image
				if @existing.include?(item.image.name) 
					puts('Already done ' + item.image.name)
					next
				end
				photo = Picasa::DefaultPhoto.new
				photo.album = @album
				photo.description = item.caption
				photo.file = File.open @folder + item.image.name + '.' + item.image.extension
				begin
					photo.picasa_save!
					open(@folder+'photosDone.txt', 'a') {|f|
						f.puts(item.image.name)
					}
					puts "Uploaded " + @folder + item.image.name + "." + item.image.extension
				rescue Exception
					open(@folder+'photoErrors.txt', 'a') {|f|
						f.puts(item.image.name)
					}
					puts "Error with " + @folder + item.image.name + '.' + item.image.extension 
				end
			end
		end
	end
end


