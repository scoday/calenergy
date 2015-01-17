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
  # set color
  valid_color = [:'000000', :'00FFFF', :'0000FF', :'D2691E', 'DC143C', :'008B8B', :'7FFF00', :'006400', :'8B008B', :'6B8E23', :'FFFF00', :'800080'] 
  options[:color] = :'000000'
  opts.on( '-c', '--color COLOR', valid_color, "Specify which color the line should be (default is black)" ) do |c|
    options[:color] = c
  end
end.parse!

# Copy options into easier to read variables
source = options[:source].to_s
file = options[:file]
date = options[:date]
color = options[:color]

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
<graph caption='California #{source} #{date}' xAxisName='Hour' yAxisName='Output (MW)' hovercapbg='FFECAA' hovercapborder='F47E00' formatNumberScale='0' decimalPrecision='0' showvalues='0' animation='1' numdivlines='3' numVdivlines='0' yaxisminvalue='0' yaxismaxvalue='500' lineThickness='3' rotateNames='1'>
<categories>
  <category name="0" />
  <category name="1" />
  <category name="2" />
  <category name="3" />
  <category name="4" />
  <category name="5" />
  <category name="6" />
  <category name="7" />
  <category name="8" />
  <category name="9" />
  <category name="10" />
  <category name="11" />
  <category name="12" />
  <category name="13" />
  <category name="14" />
  <category name="15" />
  <category name="16" />
  <category name="17" />
  <category name="18" />
  <category name="19" />
  <category name="20" />
  <category name="21" />
  <category name="22" />
  <category name="23" />
</categories>
<dataset seriesname="#{source}" color='#{color}' showvalue='1'>
#{tuples.join("\n")}
</dataset>
</graph>
DOC
