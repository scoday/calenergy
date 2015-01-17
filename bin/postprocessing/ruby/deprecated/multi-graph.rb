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

  # get source
  valid_sources = [:hydro, :imports, :nuclear, :renewable, :thermal, :wind, :geothermal, :biomass, :biogas, :solarpv, :solarthermal, :smallhydro]
  options[:source] = :hydro
  opts.on( '-s', '--source SOURCE FILE', valid_sources, "Specify source (defaults to hydro)" ) do |s|
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
#  tuples << "('#{date}', #{hour}, #{number})"
  tuples << "<set value='#{number}' />"
end

# Output an insert statement to insert all readings
puts <<-DOC
<graph caption='California #{source} #{date}' xAxisName='Hour' yAxisName='Output (MW)' hovercapbg='FFECAA' hovercapborder='F47E00' formatNumberScale='0' decimalPrecision='0' showvalues='0' animation='1' numdivlines='3' numVdivlines='0' yaxisminvalue='0' yaxismaxvalue='3800' lineThickness='3' rotateNames='1'>
<dataset seriesname="#{source}" color='D64646' showvalue='1'>
#{tuples.join("\n")}
</dataset>
DOC
