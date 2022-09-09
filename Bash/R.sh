#!/bin/bash

echo "== Starting Statistical Analysis & Report generation =="

myargumentfile_2=param_R.txt
while read list; do
  param2+=$(echo $list | cut -d "=" -f2)
  param2+=" "
done <$myargumentfile_2
echo $param2

echo $PWD
echo $param2

Rscript $PWD/run.R $param2

echo "== CoMarker completed! =="