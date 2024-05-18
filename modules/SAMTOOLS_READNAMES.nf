process SAMTOOLS_READNAMES {
    label 'lowmem'
    container 'ebird013/samtools:1.17'

    input:
        tuple val(sample), file(alignment)
    output:
        tuple val(sample), path("${sample}_readnames.txt"), emit: readnames

    script:

    """
    samtools view ${alignment} | cut -f 1 | sort | uniq > ${sample}_readnames.txt
    """
}