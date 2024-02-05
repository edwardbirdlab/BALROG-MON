process RENAME_READS {
    label 'ultralow'
    container 'ebird013/seqtk:1.4'
    publishDir "${params.project_name}/${task.process}", mode: 'symlink', overwrite: true

    input:
        tuple val(sample), file(fastq)
    output:
        tuple val(sample), path("${sample}_rename.fastq.gz"), emit: renamed_reads

    script:

    """
    convert_fastq.sh ${fastq} ${sample}_rename.fastq.gz
    """
}