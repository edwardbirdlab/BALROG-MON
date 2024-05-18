process CONCAT_FQ {
    label 'lowmem'
    container 'ebird013/seqtk:1.4'

    input:
        file(fastqs)

    output:
        path("concat_fastqs.fastq.gz"), emit: concat_reads

    script:

    """
    cat *.fastq.gz > concat_fastqs.fastq.gz
    """
}