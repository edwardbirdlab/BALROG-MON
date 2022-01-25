process trim_galore {
	container 'quay.io/biocontainers/trim-galore:0.6.7--hdfd78af_0'
    input:
        tuple val(sample), file(fastqs)
    output:
	    tuple val(sample), file("${sample}_val_1.fq.gz"), file("${sample}_val_2.fq.gz")
	    tuple val(sample), path("*report.txt")
	    tuple val(sample), file("${sample}_1.fq.gz_trimming_report.txt"), file("${sample}_2.fq.gz_trimming_report.txt")


    script:

    """
    trim_galore \\
            --cores 4 \\
            --paired \\
            --basename ${sample} \\
            ${fastqs[0]} \\
            ${fastqs[1]}
    """
}

/* At some point add in option for clipping of 3' and 5'. */
/* Add in function for determining core number */