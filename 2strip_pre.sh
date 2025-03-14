#!/bin/bash


read datdir

cd $datdir

for i in $(ls *)
do 
    mv $i ${i#*__}
done

cd ..
