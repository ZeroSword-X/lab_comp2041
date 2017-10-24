#!/usr/bin/python3

import sys
import re

word = re.sub(r'[^a-zA-Z]', '', sys.argv[1])

word1 = word.lower()
word2 = word1[::-1]

print(word1 == word2)
