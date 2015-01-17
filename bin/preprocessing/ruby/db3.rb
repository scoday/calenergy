#!/usr/bin/ruby -w 
#---------------------------------------------------------#
# GNU                                                     #
# Purpose: Format files for mysql insert                  #
# Maintainer: scoday@gmail.com                            #
#---------------------------------------------------------#
require 'rubygems'
#require 'fastercsv'
require 'date'
require 'mysql'

@source= "hydro"
@source_comment = "" 
@date = (Date.today-5).strftime('%Y%m%d') 
@idnumber = 0
numbers = Array.new

File.open("/home/scoday/scoenergy/data/caliso-hydro/caliso-20121202-hydro.log").each do |line| numbers << line.strip.to_i
end

puts "INSERT INTO production_#@source (prod_date,prod_hour,prod_output), VALUES ('#@date', '#{@idnumber += 1}', '#{numbers.join("', ")}')"
