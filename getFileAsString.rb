#!/usr/bin/ruby

def get_file_as_string(filename)
  data = ''
  f = File.open(filename, "r") 
  f.each_line do |line|
    data += line.gsub(";s:4:\"type\";", ";s:9:\"extension\";");
  end
  return data
end


