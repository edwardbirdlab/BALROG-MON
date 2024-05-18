process SAMTOOLS_UNMAPPED_ONT {
    label 'samtoolssort'
    container 'ebird013/samtools:1.17'

    input:
        tuple val(sample), file(sam)
    output:
        tuple val(sample), path("${sample}_unmapped.bam"), emit: unmapped_bam

    script:

    """
    samtools view -bS ${sam} > ${sample}.bam
    samtools view -b -f4 ${sample}.bam > ${sample}_unmapped.bam
    """
}