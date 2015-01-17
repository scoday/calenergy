#!/usr/bin/python
import time;  # This is required to include time module.

TODAY = print (time.strftime("%Y-%m-%d"))

localtime = time.asctime( time.localtime(time.time()) )
print "Local current time :", localtime
print (time.strftime("%d/%m/%Y"))
print (time.strftime("%Y-%m-%d"))
print TODAY 
