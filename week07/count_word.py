#!/usr/bin/python3

import sys
import re

count = 0
word = sys.argv[1].lower()
for line in sys.stdin:
   words = []
   line = line.lower()
   words = re.findall(r'\b'+word+r'\b', line)
   count += len(words)

print("%s occurred %d times" %(sys.argv[1], count))
