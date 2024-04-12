process SAMTOOLS_READNAMES {
    label 'lowmem'
    container 'ebird013/samtools:1.17'
    publishDir "${params.project_name}/Host_Depletion/${task.process}", mode: 'copy', overwrite: true

    input:
        tuple val(sample), file(alignment)
    output:
        tuple val(sample), path("${sample}_readnames.txt"), emit: readnames

    script:

    """
    samtools view ${alignment} | cut -f 1 | sort | uniq > ${sample}_readnames.txt
    """
}