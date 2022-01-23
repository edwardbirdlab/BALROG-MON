process trim_galore {
	container 'https://depot.galaxyproject.org/singularity/trim-galore:0.6.7--hdfd78af_0'
    input:
        tuple val(sample), file(fastqs)
    output:
	    tuple val(sample), file("${sample}_val_1.fq.gz"), file("${sample}_val_2.fq.gz")
	    tuple val(sample), path("*report.txt")
	    tuple val(sample), path("*.zip")

    script:

    """
    trim_galore \
    --cores 4 \
    --paired \
    --gzip \
    --basename ${sample} \
    ${fastqs[0]} \
    ${fastqs[1]}
    """
}

/* At some point add in option for clipping of 3' and 5'. */
/* Add in function for determining core number */