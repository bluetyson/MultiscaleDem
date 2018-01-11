#!/usr/bin/env bash
flt=$1
echo "Constructing local, meso and broad scale MaxElevationDeviation for $1.flt"

whitebox_tools -r=MaxElevationDeviation -v --dem=$PWD/$1.flt \
    -out_mag=$PWD/$1_mag1.flt \
    --out_scale=$PWD/$1_scale1.flt \
    --min_scale=3 --max_scale=99 --step=1

whitebox_tools -r=MaxElevationDeviation -v --dem=$PWD/$1.flt \
    -out_mag=$PWD/$1_mag2.flt \
    --out_scale=$PWD/$1_scale2.flt \
    --min_scale=100 --max_scale=795 --step=5

whitebox_tools -r=MaxElevationDeviation -v --dem=$PWD/$1.flt \
    -out_mag=$PWD/$1_mag3.flt \
    --out_scale=$PWD/$1_scale3.flt \
    --min_scale=800 --max_scale=1800 --step=10

# MultiscaleTopographicPositionImage is not working on ubuntu
whitebox_tools -r=MultiscaleTopographicPositionImage -v \
    --local=$PWD/$1_mag1.flt \
    --meso=$PWD/$1_mag2.flt \
    --broad=$PWD/$1_mag3.flt \
    --output=$PWD/multiscale.flt