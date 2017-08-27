#!/usr/bin/python3

import re
import sys

count = 0
total = 0
name = str(sys.argv[1])

for line in sys.stdin:
   if re.search(name, line):
      count = count + 1
      match = re.match(r'([0-9]+) .+', line)
      total = total + int(match.group(1)) 

print("%s observations: %d pods, %d individuals" %(name, count, total))

