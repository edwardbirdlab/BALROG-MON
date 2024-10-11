#!/bin/bash -l

#SBATCH --partition=atlas
#SBATCH --qos=normal
#SBATCH --job-name=balrog
#SBATCH --output="balrog-std-%j-%N.out"
#SBATCH --error="balrog-std-%j-%N.err"
#SBATCH --account=nece
#SBATCH --mail-user=david.molik@usda.gov
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --time=288:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1

module purge

module load nextflow
module load apptainer

echo "$( nextflow -v )"
echo "apptainer version $( apptainer version)"

srun nextflow run . -c configs/atlas/atlas.cfg -resume
