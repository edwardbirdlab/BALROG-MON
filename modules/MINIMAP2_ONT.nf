process MINIMAP2_ONT {
    label 'midmemlong'
    container 'ebird013/minimap2:2.26'

    input:
        tuple val(sample), file(fastq), file(ref)
    output:
        tuple val(sample), path("${sample}.sam"), emit: sam
        path("versions.yml"), emit: versions

    script:

    """
    minimap2 -ax map-ont ${ref} ${fastq} > ${sample}.sam 

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        Minimap2: \$(minimap2 --version 2>&1)
    END_VERSIONS 
    """
}