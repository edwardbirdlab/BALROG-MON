process trimgalore {
	container 'https://depot.galaxyproject.org/singularity/trim-galore:0.6.7--hdfd78af_0'
    input:
        tuple val(sample), file(fastq_1), file(fastq_2)
    output:
	    tuple val(sample), file(${sample}_val_1.fq.gz), file(${sample}_val_2.fq.gz) , emit: trimmed_reads
	    tuple val(sample), path("*report.txt"), emit: trimgalore_log
	    tuple val(sample), path("*.zip") , emit: trimgalore_zip

    script:

    """
    trim_galore \\
            --cores 4 \\
            --paired \\
            --gzip \\
            --basename ${sample} \\
            ${fastq_1} \\
            ${fastq_2}
    """
}

/* At some point add in option for clipping of 3' and 5'. */
/* Add in function for determining core number */