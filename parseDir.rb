#!/usr/bin/ruby

require "rubygems"
require "php_serialize"
require "go_picasa_go"
require "getFileAsString.rb"
require "theuser.rb"
require "parseAlbum.rb"
require "parsePhoto.rb"


Dir.chdir(ARGV[0])
albumDirs = Dir['*/']
albumDirs.each do |albumDir|
	puts "Album: " + albumDir
	album = AlbumParser.new(ARGV[0] + albumDir, ARGV[0] + albumDir + 'album.dat')
	STDIN.gets
end




