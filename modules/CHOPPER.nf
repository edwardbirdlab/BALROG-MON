process CHOPPER {
    label 'lowmem'
	container 'ebird013/chopper:0.7.0'
    publishDir "${params.project_name}/Pre_Processing/Chopper/${task.process}/${sample}", mode: 'copy', overwrite: true

    input:
        tuple val(sample), file(R1)
    output:
        tuple val(sample), path("./${sample}_ch.fastq.gz"), emit: fastq

    script:

    """
    gunzip -c ${R1} | chopper -l 500 -q 15 --threads ${task.cpus} | gzip > ${sample}_ch.fastq.gz
    """
}