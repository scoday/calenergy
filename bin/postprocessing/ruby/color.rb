#!/usr/bin/ruby
require 'optparse'
require 'date'

# Create a hash to hold command line options
options = Hash.new

# Parse command line options
OptionParser.new do |opts|
  opts.banner = "Usage: graph-gen.rb [options]"
  # get filename
  opts.on('-f', '--file FILE', "Path to log file") do |f|
    options[:file] = f
  end

    # set color
  valid_color = [:'000000', :'0000FF', :'A52A4A', :00008B, :006400, :FF1493, :696969, :FFD700, :008000, :6B8E23, :4682B4, :2F4F4F, :E9967A]
  options[:color] = :000000
  opts.on( '-c', '--source COLOR', valid_color, "Specify which color the line should be (default is black)" ) do |c|
    options[:color] = s
  end
  color = options[:color]
end

