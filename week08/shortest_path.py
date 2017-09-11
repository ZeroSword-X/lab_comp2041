#!/usr/bin/python3

import re
import sys
import collections

class PriorityQueue: 

   def __init__(self):
      self.queue = []

   def isEmpty(self):
      if len(self.queue) > 0:
         return False
      else:
         return True

   def enterQueue(self, node):
      if len(self.queue) > 0:
         i = 0
         for n in self.queue:
            if node[1] < self.queue[i][1]:
               self.queue.insert(i, node)
               return
            i += 1            

      self.queue.append(node)

   def leaveQueue(self):
      assert(len(self.queue) > 0)
      return self.queue.pop(0)[0]

#---------------------------------------------------------------------------

graph = collections.defaultdict(lambda: collections.defaultdict(int))
visited = collections.defaultdict(int)
dist = collections.defaultdict(int)
pred = collections.defaultdict(str)

for line in sys.stdin:
   data = line.split(r' ')
   town1 = data[0]
   town2 = data[1]
   d = int(data[2])
   
   graph[town1][town2] = d
   graph[town2][town1] = d

pQueue = PriorityQueue()
source = sys.argv[1]
dest = sys.argv[2]
towns = graph.keys()

for town in towns:
   dist[town] = sys.maxsize

dist[source] = 0
pQueue.enterQueue((source, 0))

while not pQueue.isEmpty():
   town = pQueue.leaveQueue()

   if town == dest:
      start = dest
      end = source
      path = dest + "."

      while pred[start]:
         if start == end:
            break
         else:
            path = pred[start] + " " + path
            start = pred[start]

      print("Shortest route is length = %d: %s" %(dist[dest], path))
      sys.exit(0)

   visited[town] = 1
   neighbours = graph[town].keys()

   for n in neighbours:
      if visited[n]:
         continue
      
      if dist[town] + graph[town][n] < dist[n]:
         pred[n] = town
         dist[n] = dist[town] + graph[town][n]
         pQueue.enterQueue((n, dist[n]))

print("No route from %s to %s" %(source, dest))
