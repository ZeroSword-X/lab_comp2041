#!/usr/bin/python3

import re
import sys

lines = []
for line in sys.stdin:
   lines.append(line)

for line in lines:
   line = re.sub(r'\n$', '', line)
   words = re.split(r'\s+', line)

   for word in words:
      counter = {}
      for char in word:
         char = char.lower() 
         
         if char in counter:
            counter[char] += 1
         else:
            counter[char] = 1

      times = -1
      equi = True

      for char in counter.keys():
         if times == -1:
            times = counter[char]
         else:
            if times != counter[char]:
               equi = False
               break
      
      if equi:
         sys.stdout.write(word)
         sys.stdout.write(' ')

   sys.stdout.write('\n')
