#!/bin/sh

IFS=$'\n'

# print HTTP header
# its best to print the header ASAP because 
# debugging is hard if an error stops a valid header being printed

echo Content-type: text/html
echo

# print page content
# print all environment variables
# This is interpreted as HTML so we replace some chars by the equivalent HTML entity.
# Note this will not guarantee security in all contexts.

agent=""
ip=""
hostname=""

info=`env | sed 's/&/\&amp;/;s/</\&lt;/g;s/>/\&gt;/g'`

for line in $info
do

   if printf "%s" $line | egrep '^HTTP_USER_AGENT=' > /dev/null
   then
      agent=`printf "%s" $line | sed -e 's/^HTTP_USER_AGENT=//'`
   elif printf "%s" $line | egrep '^REMOTE_ADDR=' > /dev/null
   then
      ip=`printf "%s" $line | sed -e 's/^REMOTE_ADDR=//'`
   fi

done

hostname=`host $ip | cut -d' ' -f5 | sed -e 's/\.$//'`

cat << eof
<!DOCTYPE html>
<html lang="en">
<head>
<title>Browser IP, Host and User Agent</title>
</head>
<body>
Your browser is running at IP address: <b>$ip</b>
<p>
Your browser is running on hostname: <b>$hostname</b>
<p>
Your browser identifies as: <b>$agent</b>
</body>
</html>
eof

