#!/usr/bin/python
#
# basenamesort.py
#
# Unix-style filter that sorts a newline-separated
# list of files by the file basename
#
# Example usage:  cat files.txt | basenamesort.py

import sys
import os

tempDict = {}

for line in sys.stdin.xreadlines():
  tempDict[os.path.basename(line)] = line.rstrip()

sorted = tempDict.keys()

sorted.sort()

for key in sorted:
  print tempDict[key]

