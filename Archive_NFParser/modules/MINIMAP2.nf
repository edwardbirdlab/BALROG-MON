process MINIMAP2 {
    label 'lowmem'
    container 'ebird013/minimap2:2.26'

    input:
        tuple val(sample), file(fastq1), file(fastq2), file(ref)
    output:
        tuple val(sample), path("${sample}.sam"), emit: sam

    script:

    """
    minimap2 -ax sr ${ref} ${fastq1} ${fastq1} > ${sample}.sam 
    """
}