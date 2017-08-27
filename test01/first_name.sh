#!/bin/sh

egrep 'COMP[29]041' "$1" | cut -d'|' -f3 | cut -d' ' -f2 | sort | uniq -c | sort -nrk1 | head -1 | sed -e 's/^[ ]\+//g' | cut -d' ' -f2
