#!/usr/bin/python3

import re
import sys
import glob

for file in glob.glob("lyrics/*.txt"):
    f = open(file, "r")

    f.close();
