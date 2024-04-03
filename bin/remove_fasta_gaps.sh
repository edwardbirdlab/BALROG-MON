#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 input_file.fasta"
    exit 1
fi

input_file="$1"

sed '/^>/! s/\-//g' input_file

echo "Conversion completed. Output saved to $output_file"