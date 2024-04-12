process CONCAT_FQ {
    label 'lowmem'
    //container 'ebird013/longstitch:1.0.5'
    publishDir "${params.project_name}/Assembly/${task.process}", mode: 'symlink', overwrite: true

    input:
        file(fastqs)

    output:
        path("concat_fastqs.fastq.gz"), emit: concat_reads

    script:

    """
    cat *.fastq.gz > concat_fastqs.fastq.gz
    """
}