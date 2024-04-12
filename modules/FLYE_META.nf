process FLYE_META {
    label 'midmem'
    container 'ebird013/flye:2.9.3'
    publishDir "${params.project_name}/Assembly/${task.process}", mode: 'copy', overwrite: true

    input:
        tuple val(sample), file(fastq)
    output:
        tuple val(sample), path("${sample}_fly"), emit: metagenome

    script:

    """
    mkdir ${sample}_fly
    flye --nano-hq ${fastq} --meta -o ${sample}_fly -t ${task.cpus} 
    """
}