process SAMTOOLS_STATS {
    label 'verylow'
    container 'ebird013/samtools:1.17'

    input:
        tuple val(sample), file(alignment)
    output:
        tuple val(sample), path("${sample}_align.txt"), emit: stats

    script:

    """
    samtools stats ${alignment} > ${sample}_align.txt
    """
}