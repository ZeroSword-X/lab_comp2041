#!/bin/sh

tmp_file="tmp_file_$$_hihi"
cat "$1" | sed -e 's/[aeiouAEIOU]//g' > $tmp_file
cat $tmp_file > "$1"
rm -rf $tmp_file
