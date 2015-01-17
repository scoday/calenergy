#!/usr/bin/ruby -w 
#---------------------------------------------------------#
# GNU                                                     #
# Purpose: Format files for mysql insert                  #
# Maintainer: scoday@gmail.com                            #
#---------------------------------------------------------#
require 'rubygems'
require 'fastercsv'
require 'date'
require 'mysql'

time    = Time.new
LogTime = time.strftime("%Y%m%d")
@LogTime = (Date.today-5).strftime('%Y%m%d')

def read_file(file_name)
  file = File.open(file_name, "r")
  data = file.read
  file.close
  return data
end

def cali_iso
  puts File.read("/home/scoday/dev/scoenergy/data/caliso-hydro/caliso-#@LogTime-hydro.log")
end

def caliso_csvinator
result = []
File.open("/home/scoday/dev/scoenergy/data/caliso-hydro/caliso-#@LogTime-hydro.log","r") do |handle|
  handle.each_line do |line|
    result << line.split(",").collect(&:strip)
  end
result.flatten!
puts result # => big array of values
end # closes automatically when EOF reached
end
#cali_iso
caliso_csvinator
