#!/bin/bash

# So you can either list numbers
# for i in 01 09 14 15
# or count the numbers off
# for i in {01..15} which IS smart enough to go 01 02 .. 14 15
for i in {01..08};
do
    day=7
    # MAKE SURE THERE ARE NO SPACES
    # IN YOUR VARIABLE DECLARATION
    #datdir=vdj_rubella_run5$i
    datdir=atac_yfv_$day$i
    mkdir $datdir

    mv *ATACYD$day$i*-*/* $datdir/.
    rm -r *ATACYD$day$i*-*

done
