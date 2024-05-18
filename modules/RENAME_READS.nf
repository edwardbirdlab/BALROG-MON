process RENAME_READS {
    label 'ultralow'
    container 'ebird013/seqtk:1.4'

    input:
        tuple val(sample), file(fastq)
    output:
        tuple val(sample), path("${sample}_rename.fastq.gz"), emit: renamed_reads

    script:

    """
    convert_fastq.sh ${fastq} ${sample}_rename.fastq.gz
    """
}