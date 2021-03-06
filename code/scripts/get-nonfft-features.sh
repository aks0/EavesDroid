#!/bin/bash

if [[ $# -lt 1 ]]
then
    echo 'usage: ./get-nonfft-features.sh <input-dir> <label-type>';
    echo 'example1: ./get-nonfft-features.sh raw-dataset';
    echo 'example2: ./get-nonfft-features.sh raw-dataset lr';
    echo 'example3: ./get-nonfft-features.sh raw-dataset triad';
    exit
fi

path=../../data

# copy the class files to this directory
cp ../feature_extractor/*.java .
javac *.java

# run the feature extractor to extract the gforce values
java -cp . FeatureExtractor -d $1 -gforce -label $2
echo "features file written at ... $path/features/$1.csv"

# clean the class files
rm -f *.class *.java
echo "cleaning .class files"

# copy the gforce files to a separate folder
rm -rf $path/$1-gforce
mkdir $path/$1-gforce
echo "new directory created '$path/$1-gforce'"
cp -r $path/$1/* $path/$1-gforce/
find $path/$1 -name "*gforce\.csv" -exec rm -f {} +
find $path/$1-gforce ! -name "*gforce\.csv" -type f -exec rm -f {} +