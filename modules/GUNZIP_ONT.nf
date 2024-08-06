process GUNZIP_ONT {
    label 'lowmem'
    container 'ebird013/seqtk:1.4'

    input:
        tuple val(sample), file(fastq)

    output:
        tuple val(sample), path("/temp/${sample}.fastq"), emit: decomp

    script:

    """
    mkdir temp
    mv ${fastq} temp/${sample}t.fastq.gz
    gunzip -f temp/ ${sample}.fastq.gz
    """
}