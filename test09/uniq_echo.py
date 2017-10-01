#!/usr/bin/python3

import sys

echoed = {}
for arg in sys.argv[1:]:
   if arg not in echoed:
      sys.stdout.write(arg)
      sys.stdout.write(" ")
      echoed[arg] = 1

print()
