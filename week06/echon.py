#!/usr/bin/python3

import re
import sys

if len(sys.argv) != 3:
   print("Usage: %s <number of lines> <string>" %(sys.argv[0]), file=sys.stderr)
   exit(1)

if not re.search(r'^\d+$', sys.argv[1]):
   print("%s: argument 1 must be a non-negative integer" %(sys.argv[0]), file=sys.stderr)
   exit(1)

n = int(sys.argv[1])
for i in range(0,n):
   print("%s" %(sys.argv[2]))
