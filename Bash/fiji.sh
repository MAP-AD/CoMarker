#!/bin/bash

echo "== Starting Image Analysis =="

myargumentfile_1=param_fiji.txt
while read list; do
  param1+=$(echo $list | cut -d "=" -f2)
  param1+="*"
  done <$myargumentfile_1
echo $param1

/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx -macro CoMarker_headless_Macro.ijm $param1

echo "== Image Analysis done ! =="