#!/usr/bin/python3

import sys
import re

lines = []
with open(sys.argv[1], 'r') as f:
   for line in f:
      line = re.sub(r'[aeiouAEIOU]', '', line)
      lines.append(line)

with open(sys.argv[1], 'w') as f:
   for line in lines:
      print(line, end='', file=f)
