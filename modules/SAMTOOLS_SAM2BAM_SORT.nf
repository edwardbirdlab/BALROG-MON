process SAMTOOLS_SAM2BAM_SORT {
    label 'lowmem'
    container 'ebird013/samtools:1.17'
    publishDir "${params.project_name}/Genome_QC/Samtools", mode: 'symlink', overwrite: true

    input:
        tuple val(sample), file(sam)
    output:
        tuple val(sample), path("${sample}_sorted.bam"), path("${sample}_sorted.bam.bai"), emit: sort_bam

    script:

    """
    samtools view -S -b ${sam} > ${sample}_sorted.bam
    samtools sort ${sample}_sorted.bam -o ${sample}_sorted.bam
    samtools index ${sample}_sorted.bam
    """
}