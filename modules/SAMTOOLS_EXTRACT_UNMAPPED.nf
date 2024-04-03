process SAMTOOLS_EXTRACT_UNMAPPED {
    label 'samtoolssort'
    container 'ebird013/samtools:1.17'
    publishDir "${params.project_name}/Host_Depletion/Bowtie2", mode: 'symlink', overwrite: true

    input:
        tuple val(sample), file(sam)
    output:
        tuple val(sample), path("${sample}_R1.fq.gz"), path("${sample}_R2.fq.gz"), emit: non_host_reads

    script:

    """
    samtools view -bS ${sam} > ${sample}.bam
    samtools view -b -f4 ${sample}.bam > ${sample}_unmapped.bam
    samtools sort -n -m ${task.memory.toGiga()}G -@ ${task.cpus} ${sample}_unmapped.bam -o ${sample}_unmapped_sorted.bam
    samtools fastq -@ ${task.cpus} ${sample}_unmapped_sorted.bam -1 ${sample}_R1.fq.gz -2 ${sample}_R2.fq.gz
    """
}