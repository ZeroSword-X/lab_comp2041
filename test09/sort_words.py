#!/usr/bin/python3

import sys
import re

for line in sys.stdin:
   line = line.strip()
   words = re.split(r'\s+', line)
 
   for word in sorted(words):
      print(word + " ", end = '')

   print()
