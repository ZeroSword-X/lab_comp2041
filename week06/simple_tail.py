#!/usr/bin/python3

import sys

lines=[]
for arg in sys.argv[1:]:
   f = open(arg, "r")
   
   for line in f:
      lines.append(line)

   index = len(lines) - 10
   if index < 0:
      index = 0

   for line in lines[index:]: 
      print("%s" %(line), end='')

   lines.clear()
