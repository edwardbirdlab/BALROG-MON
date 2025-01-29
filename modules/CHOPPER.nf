process CHOPPER {
    label 'lowmem'
	container 'ebird013/chopper:0.7.0'

    input:
        tuple val(sample), file(R1)
    output:
        tuple val(sample), path("./${sample}_ch.fastq.gz"), emit: fastq
        path("versions.yml"), emit: versions

    script:

    """
    gunzip -c ${R1} | chopper -l ${params.ont_min_seq_len} -q ${params.ont_average_read_min_qscore} --threads ${task.cpus} | gzip > ${sample}_ch.fastq.gz

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        chopper: \$(chopper --version 2>&1 | grep "chopper" | sed -e "s/chopper //g")
    END_VERSIONS 
    """
}