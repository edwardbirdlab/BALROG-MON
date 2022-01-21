process trimgalore {
	publishDir "${out_dir}/${project_name}/trimgalore", mode: 'copy', overwrite: false
	container 'https://depot.galaxyproject.org/singularity/trim-galore:0.6.7--hdfd78af_0'
    input:
        tuple val(sample), file(fastq_1), file(fastq_2)
    output:
	    tuple val(meta), path("*.fq.gz")    , emit: trimmed_reads
	    tuple val(meta), path("*report.txt"), emit: trimgalore_log
	    tuple val(meta), path("*.zip") , emit: trimgalore_zip

    script:

    """
    trim_galore \\
            --cores 4 \\
            --paired \\
            --gzip \\
            ${sample}_1.fastq.gz \\
            ${sample}_2.fastq.gz
    """
}

/* At some point add in option for clipping of 3' and 5'. */