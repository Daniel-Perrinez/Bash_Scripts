#!/bin/bash
echo "START"
# Read in a list of hostnames from a file
while read hostname; do
  # Run nslookup on each hostname and output the results to a file
  echo "--------------------------------- START $hostname -------------------------------------"  >> ./output.txt
  nslookup $hostname >> ./output.txt
  echo "--------------------------------- END $hostname -------------------------------------"  >> ./output.txt
done < hostnames.txt
echo "DONE"