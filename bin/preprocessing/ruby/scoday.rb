#!/usr/bin/ruby

require 'optparse'
require 'date'

# Create a hash to hold command line options
options = Hash.new

# Parse command line options
OptionParser.new do |opts|
  opts.banner = "Usage: scoday [options]"

  # get filename
  opts.on('-f', '--file FILE', "Path to log file") do |f|
    options[:file] = f
  end

  # get source
  valid_sources = [:hydro, :imports, :nuclear, :renewable, :thermal, :wind, :geothermal, :biomass, :biogas, :solarpv, :solarthermal, :smallhydro]
  options[:source] = :hydro
  opts.on( '-s', '--source SOURCE', valid_sources, "Specify source (defaults to hydro)" ) do |s|
    options[:source] = s
  end

  # get date
  options[:date] = (Date.today-5)  
  opts.on('-d', '--date DATE', "Date to use, (defaults to 5 days ago)") do |d|
    options[:date] = Date.parse(d)
  end  
  options[:date] = options[:date].strftime('%Y-%m-%d')
end.parse!

# Copy options into easier to read variables
source = options[:source].to_s
file = options[:file]
date = options[:date]

# Make sure we were given a valid file to parse
if file == nil
  puts "No log file specified"
  exit
elsif !File.exist?(file)
  puts "File #{file} does not exist"
  exit
end

# Read numbers from file and create tuple strings for each number
tuples = Array.new
File.open(file).each_with_index do |l, index|
  hour = index + 1
  number = l.strip.to_i
  tuples << "('#{date}', #{hour}, #{number})"
end

# Output an insert statement to insert all readings
puts <<-DOC
INSERT INTO production_#{source}
(prod_date, prod_hour, prod_output)
VALUES
#{tuples.join(",\n")};
DOC
