#!/bin/bash
#

echo "Type the month you want to check followed by [ENTER]:"

read month

if (( ("$month" % 400) == "0" )) || (( ("$month" % 4 == "0") && ("$month" % 100 ! = "0") )); then
  echo "$month is a leap year."
else
  echo "Not a leap year."
fi
