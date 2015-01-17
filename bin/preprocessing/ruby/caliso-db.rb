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
  array = File.read("/home/scoday/dev/scoenergy/data/caliso-hydro/caliso-#@LogTime-hydro.log").split(",").map(&:strip)
  data = file.read
  file.close
  return data
end

def cali_iso
  puts File.read("/home/scoday/dev/scoenergy/data/caliso-hydro/caliso-#@LogTime-hydro.log")
end

def hydro_db
  begin
      db_con = Mysql.new 'localhost', 'root', '', 'scoenergy'
      db_con.query("SHOW DATABASES")
  rescue Mysql::Error => e
      puts e.errno
      puts e.error
  ensure
      db_con.close if db_con
  end
end
  

cali_iso
hydro_db
