#!/bin/bash
#SBATCH -N 1
#SBATCH -n 2
#SBATCH -p long
#SBATCH -o "balrog.stdout.%j.%N" 		# standard out %j adds job number to outputfile name and %N adds the node
#SBATCH -e "balrog.stderr.%j.%N" 		#optional but it prints our standard error
#SBATCH --mail-user=david.molik@usda.gov
#SBATCH --mail-type=START,END,FAIL               #will receive an email when job ends or fails

#module load singularityCE/3.11.4
module load apptainer
module load nextflow/23.10.1

nextflow run . -c configs/ceres/ceres.cfg -resume
