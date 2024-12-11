### Running Balrog on USDA ARS Ceres

> This file is meant to help you successfully run balrog on ceres scinet services

```bash
# in the top level directory of balrog
cp configs/ceres/balrog.template.slurm balrog.slurm
vim balrog.slurm    # edit slurm script with your email, change apptainer libraryDir and cacheDir if needed.
vim samplesheet.csv # create a samplesheet of your input files
vim nextflow.config # edit nextflow config to have your samplesheet and preferred runtype
sbatch balrog.slurm
```

This file and all files in this directory are in the public domain. 
