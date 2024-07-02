#!/bin/bash
# This script takes a folder name as an argument and writes the absolute paths of all the llvm bitcode files in it recursively to a file named bitcode.lst
# Each line in the file contains one file path

# Check if the argument is a valid folder name
if [ ! -d "$1" ]; then
  echo "Invalid folder name: $1"
  exit 1
fi

# Find all the llvm bitcode files in the folder and write their absolute paths to bitcode.lst
find "$1" -type f -name "*.c" -exec readlink -f {} \; > $2.part1.lst
find "$1" -type f -name "*.h" -exec readlink -f {} \; > $2.part2.lst
echo "Output file: $2.lst"