#!/usr/bin/python3

import sys

sorted_nums = sorted(list(sys.argv[1:]), key=lambda x: int(x))
print(sorted_nums[int(len(sorted_nums)/2)])
