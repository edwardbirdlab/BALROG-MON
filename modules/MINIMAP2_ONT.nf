process MINIMAP2_ONT {
    label 'midmemlong'
    container 'ebird013/minimap2:2.26'
    publishDir "${params.project_name}/Pre_Processing/Minimap2_ONT_RefGen", mode: 'symlink', overwrite: true

    input:
        tuple val(sample), file(fastq), file(ref)
    output:
        tuple val(sample), path("${sample}.sam"), emit: sam

    script:

    """
    minimap2 -ax map-ont ${ref} ${fastq} > ${sample}.sam 
    """
}