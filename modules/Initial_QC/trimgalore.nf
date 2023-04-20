process trim_galore {
    label 'lowmem'
	container 'library://edwardbird/bara/trimgalore:0.6.7'
    publishDir "${params.project_name}/Pre_Processing/trim_galore", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fastqs)
    output:
	    tuple val(sample), path("${sample}_val_1.fq.gz"), path("${sample}_val_2.fq.gz"), emit: trimmed_fastq
	    tuple val(sample), path("*report.txt"), emit: trim_galore_report
	    tuple val(sample), path("${sample}_1.fq.gz_trimming_report.txt"), path("${sample}_2.fq.gz_trimming_report.txt"), emit: trim_galore_red_reports


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