#!/bin/bash
# Tidy up the output from a "script" session:
#    mostly just removes annoying whitespace...
sed -r -e 's/\^M\^M*$//g' -e 's/\\*/\
/g' | sed -r -e 's/[[:space:]]+$//g' | cat -s
