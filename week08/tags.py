#!/usr/bin/python3

import re
import sys
import collections
import subprocess

if sys.argv[1] == "-f":
   url = sys.argv[2]
else:
   url = sys.argv[1]

counts = collections.defaultdict(int)
webpage = subprocess.check_output(["wget", "-q", "-O-", url], universal_newlines=True)
webpage = webpage.lower()
tags = re.findall(r'<[^>]+>', webpage)

for tag in tags:
   if not re.search(r'</', tag):
      result = re.search(r'<(\w+)', tag)

      if result:
         key = result.group(1)
         counts[key] += 1

if sys.argv[1] == "-f":
   for tag in sorted(counts, key = lambda k: (counts[k], k)):
      print("%s %d" %(tag, counts[tag]))
else:
   for tag in sorted(counts):
      print("%s %d" %(tag, counts[tag]))

