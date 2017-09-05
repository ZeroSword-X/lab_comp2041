#!/usr/bin/python3

import re
import sys
import glob
import math
import collections

n_words = collections.defaultdict(int)
word_dict = collections.defaultdict(dict)
prob = collections.defaultdict(dict)

flag = False
if sys.argv[1] == "-d":
   flag = True
   sys.argv.pop(1)



for file in glob.glob("lyrics/*.txt"):
   f = open(file, "r")

   searchObj = re.search(r'lyrics\/(.*)\.txt', file)
   artist = searchObj.group(1)
   artist = re.sub(r'[^a-zA-Z]', ' ', artist)

   word_dict[artist] = collections.defaultdict(int)

   for line in f:
      line = line.lower()
      words = re.split(r'[^a-zA-Z]+', line)
   
      for w in words:
         if w:
             n_words[artist] += 1
             word_dict[artist][w] += 1
 
   f.close()


for song in sys.argv[1:]:
   f = open(song, "r")
   prob[song] = collections.defaultdict(float)

   for line in f:
      line = line.lower()
      words = re.split(r'[^a-zA-Z]+', line)
   
      for w in words:
         for artist in word_dict.keys():
            if w:
               prob[song][artist] += math.log((word_dict[artist][w]+1)/n_words[artist])
       
   f.close()

for song in sorted(prob.keys()):
   artists = sorted(prob[song].keys(), key=prob[song].get, reverse=True)

   if flag:
      for artist in artists:
         print("%s: log_probability of %.1f for %s" %(song, prob[song][artist], artist))

   print("%s most resembles the work of %s (log-probability=%.1f)" %(song, artists[0], prob[song][artists[0]])) 
