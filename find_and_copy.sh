#!/bin/bash 
# helper tool for searching specified file(s) and copy the found ones to given directory

target_dir="./output/" 
target_file="*.pdf" 

# Create the target directory if necessary 
mkdir -p $target_dir 
find . -name "$target_file" | while read line; do 
    echo "Copying '$line' to '$target_dir'" 
    cp -- "$line" $target_dir
done
