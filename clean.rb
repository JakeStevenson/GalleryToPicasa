#!/usr/bin/ruby

require "rubygems"
require "php_serialize"
require "go_picasa_go"
require "theuser.rb"

while
	user = Theuser.new
	existingAlbums = user.albums

	puts "Deleting " + existingAlbums[0].title
	existingAlbums[0].picasa_destroy!
end
