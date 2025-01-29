process SAMTOOLS_STATS {
    label 'verylow'
    container 'ebird013/samtools:1.17'

    input:
        tuple val(sample), file(alignment)
    output:
        tuple val(sample), path("${sample}_align.txt"), emit: stats
        path("versions.yml"), emit: versions

    script:

    """
    samtools stats ${alignment} > ${sample}_align.txt

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        Samtools: \$(samtools --version 2>&1 | grep "samtools " | sed -e "s/samtools //g")
    END_VERSIONS 
    """
}