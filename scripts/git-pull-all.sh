#!/bin/sh

for i in *; do 
  if [ ! -d $i ]; then 
    continue; 
  fi; 
  cd $i; 
  echo $i; 
  git pull || git fetch; 
  cd ..; 
done

