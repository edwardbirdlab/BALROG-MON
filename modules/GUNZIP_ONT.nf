process GUNZIP_ONT {
    label 'lowmem'
    container 'ebird013/seqtk:1.4'

    input:
        tuple val(sample), file(fastq)

    output:
        tuple val(sample), path("${sample}_readsubset.fastq"), emit: read_subset

    script:

    """
    mv ${fastq} ${sample}_readsubset.fastq.gz
    gunzip -f ${sample}_readsubset.fastq.gz
    """
}