#!/usr/bin/env python3

import subprocess

modules = ['wheel', 'pandas']

for mod in modules:
    command = 'pip3 install ' + mod
    subprocess.run(command, shell=True)

import pandas as pd
import os
import sys

if len(sys.argv) > 1:
    # Access the command-line arguments
    argument1 = sys.argv[1]   #kraken_out

    print('Kraken Out = ' + argument1)

else:
    print("No command-line arguments provided.")


def convert_kraken_out(kraken_out):
    out = open(kraken_out, 'r')
    out_lines = out.readlines()
    out.close()
    class_lines = []
    for line in out_lines:
        if line[0] == 'C':
            class_lines.append(line)
    classed_out = open('kraken_out_classed.tsv', 'w')
    classed_out.writelines((class_lines))
    classed_out.close()
    head = ['Class', 'seq_id', 'taxid', 'len', 'kmer_info']
    df = pd.read_csv('kraken_out_classed.tsv', sep='\t', header=None, names=head)
    blobdb = df.drop(columns=['Class', 'len', 'kmer_info'])
    fake_score = ['10000' for x in range(len(blobdb))]
    blobdb['fake_scores'] = fake_score
    new_name = str(kraken_out[:-4]) + '_blobtools.tsv'
    blobdb.to_csv(new_name, sep='\t', header=False, index=False)

convert_kraken_out(argument1)