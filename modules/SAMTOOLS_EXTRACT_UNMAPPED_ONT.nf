process SAMTOOLS_EXTRACT_UNMAPPED_ONT {
    label 'samtoolssort'
    container 'ebird013/samtools:1.17'

    input:
        tuple val(sample), file(sam)
    output:
        tuple val(sample), path("${sample}_filter.fq.gz"), emit: non_host_reads

    script:

    """
    samtools view -bS ${sam} > ${sample}.bam
    samtools view -b -f4 ${sample}.bam > ${sample}_unmapped.bam
    samtools sort -n -m ${task.memory.toGiga()}G -@ ${task.cpus} ${sample}_unmapped.bam -o ${sample}_unmapped_sorted.bam
    samtools fastq -@ ${task.cpus} ${sample}_unmapped_sorted.bam -1 ${sample}_filter.fq.gz
    """
}


