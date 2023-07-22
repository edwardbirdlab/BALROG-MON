#!/usr/bin/env python3

import subprocess

modules = ['wheel', 'pandas', 'numpy', 'Bio', 'seaborn']

for mod in modules:
    command = 'pip3 install ' + mod
    subprocess.run(command, shell=True)

import pandas as pd
import numpy as np
import os
from collections import defaultdict
from Bio import SearchIO
import seaborn as sns
import sys

if len(sys.argv) > 1:
    # Access the command-line arguments
    argument1 = sys.argv[1]   #predict
    argument2 = sys.argv[2]   #prob
    argument3 = sys.argv[3]   #fasta

    print('Prediction_TSV = ' + argument1)
    print('Probability_TSV = ' + argument2)
    print('Contigs_fasta = ' + argument3)

else:
    print("No command-line arguments provided.")


def import_fasta(filename):
    sequences = {}

    with open(filename, 'r') as file:
        current_sequence = ''
        current_header = None

        for line in file:
            line = line.strip()

            if line.startswith('>'):
                # Store previous sequence (if any) and start a new sequence
                if current_header and current_sequence:
                    sequences[current_header.split(' ')[0]] = current_sequence

                current_header = line[1:]
                current_sequence = ''
            else:
                current_sequence += line

        # Store the last sequence in the file
        if current_header and current_sequence:
            sequences[current_header] = current_sequence

    return sequences


def write_fasta(sequences, filename):
    with open(filename, 'w') as file:
        for header, sequence in sequences.items():
            file.write(f'>{header}\n')
            file.write(f'{sequence}\n')

def get_unique_values(lst):
    unique_values = list(set(lst))
    return unique_values

def Merge(dict1, dict2, dict3):
    res = dict1 | dict2 | dict3
    return res

def load_data(path_predict, path_prob, contig_path):
    predict_headder = ['Contig', 'Prediction']
    prob_headder = ['Contig', 'Prob_Chromosome', 'Prob_Plasmid']
    predict = pd.read_csv(path_predict, sep='\t', header=None, names=predict_headder)
    prob = pd.read_csv(path_prob, sep='\t', header=None, skiprows=[0], names=prob_headder)   
    contigs = import_fasta(contig_path)
    return [predict, prob, contigs]

def get_fasta_name(input_fasta, added_str):
    prefix = input_fasta.split('.')[0]
    new_name = prefix + '_' + added_str + '.fasta'
    return new_name

def sort_contigs(contigs, predict, prob, contig_name):
    Plasmid_Dict = {}
    Chromo_Dict = {}
    Too_Short_Dict = {}
    
    for k,v in contigs.items():
            if predict.loc[predict['Contig'] == k]['Prediction'].values[0] == 'plasmid':
                prob_chromo = str(prob.loc[prob['Contig'] == k].values[0][1])
                prob_plas = str(prob.loc[prob['Contig'] == k].values[0][2])
                new_name = 'PLAS_' + 'P:' + prob_plas + '|C:' + prob_chromo + '_' + k
                Plasmid_Dict[new_name] = v
            elif predict.loc[predict['Contig'] == k]['Prediction'].values[0] == 'chromosome':
                if k in prob['Contig'].tolist():
                    prob_chromo = str(prob.loc[prob['Contig'] == k].values[0][1])
                    prob_plas = str(prob.loc[prob['Contig'] == k].values[0][2])
                    new_name = 'CHROMO_' + 'P:' + prob_plas + '|C:' + prob_chromo + '_' + k
                    Chromo_Dict[new_name] = v
                else:
                    prob_chromo = '1'
                    prob_plas = '0'
                    new_name = 'CHROMO_' + 'P:' + prob_plas + '|C:' + prob_chromo + '_' + k
                    Chromo_Dict[new_name] = v
            elif 'shorter_than' in  predict.loc[predict['Contig'] == k]['Prediction'].values[0]:
                new_name = 'TooShort_' + k
                Too_Short_Dict[new_name] = v
    
    merged_dict = Merge(Plasmid_Dict, Chromo_Dict, Too_Short_Dict)
    
    write_fasta(Plasmid_Dict, get_fasta_name(contig_name, 'plasmid'))
    write_fasta(Chromo_Dict, get_fasta_name(contig_name, 'chromosome'))
    write_fasta(Too_Short_Dict, get_fasta_name(contig_name, 'tooshort'))
    write_fasta(merged_dict, get_fasta_name(contig_name, 'allclass'))
    
    print('There are ' + str(len(Plasmid_Dict)) + ' plasmid sequences')
    print('There are ' + str(len(Chromo_Dict)) + ' chromosome sequences')
    print('There are ' + str(len(merged_dict)) + ' total sequences')
    print('The input database contained ' + str(len(contigs)) + ' Contigs')

def whole_process(path_predict, path_prob, contig_path):
    data = load_data(path_predict, path_prob, contig_path)
    sort_contigs(data[2],data[0],data[1],contig_path)

whole_process(argument1, argument2, argument3)