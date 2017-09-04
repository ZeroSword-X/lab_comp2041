#!/usr/bin/python3

import sys
import re

total = 0;
for line in sys.stdin:  
   words = []
   words = re.split(r'[^a-zA-Z]+', line)

   for word in words:
      if word:
         total += 1

print("%d words" %(total))
