process MINIMAP2 {
    label 'lowmem'
    container 'ebird013/minimap2:2.26'
    publishDir "${params.project_name}/Genome_QC/Minimap2", mode: 'symlink', overwrite: true

    input:
        tuple val(sample), file(fastq1), file(fastq2), file(ref)
    output:
        tuple val(sample), path("${sample}.sam"), emit: sam

    script:

    """
    minimap2 -ax sr ${ref} ${fastq1} ${fastq1} > ${sample}.sam 
    """
}