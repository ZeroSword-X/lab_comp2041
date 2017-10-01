#!/usr/bin/python3

import sys
import re

n = int(sys.argv[1])

lines = {}
count = 0
num_lines = 0

for line in sys.stdin:
   num_lines += 1
   line = line.lower()
   line = re.sub(r'\s+','', line)  
 
   if line not in lines:
      count += 1
      lines[line] = 1

      if count == n:
         print("%d distinct lines seen after %d lines read." %(count, num_lines))
         sys.exit(0)

print("End of input reached after %d lines read -  %d different lines not seen." %(num_lines, n))
