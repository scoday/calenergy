#!/usr/bin/ruby -w 
#---------------------------------------------------------#
# GNU                                                     #
# Purpose: Format files for mysql insert                  #
# Maintainer: scoday@gmail.com                            #
#                                                         #
#---------------------------------------------------------#

require 'date'
             
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
  puts File.read("/home/scoday/dev/scoenergy/data/caliso/caliso-#@LogTime.log")
end

cali_iso
