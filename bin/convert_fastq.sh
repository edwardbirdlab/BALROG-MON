#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 input_file.fastq.gz output_file.fastq.gz"
    exit 1
fi

input_file="$1"
output_file="$2"

zcat "$input_file" | awk '{print (NR%4 == 1) ? "@1_" ++i : $0}' | gzip -c > "$output_file"

echo "Conversion completed. Output saved to $output_file"