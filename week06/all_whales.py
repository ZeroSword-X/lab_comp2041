#!/usr/bin/python3

import re
import sys

count={}
total={}
for line in sys.stdin:
   line = line.lower()
   match = re.sub(r'[ ]{2,}', ' ', line)
   match = re.sub(r'[ ]+$', '', match)
   match = re.search(r'([0-9]+) (.+)', match)

   num = int(match.group(1))
   name = match.group(2)
   name = re.sub(r's$', '', name)   

   if name in count:
      count[name] = count[name] + 1
      total[name] = total[name] + num
   else:
      count[name] = 1
      total[name] = num

for key in sorted(count.keys()):
   print("%s observations: %d pods, %d individuals" %(key, count[key], total[key]))
