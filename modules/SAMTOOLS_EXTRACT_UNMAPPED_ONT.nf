process SAMTOOLS_EXTRACT_UNMAPPED_ONT {
    label 'samtoolssort'
    container 'ebird013/samtools:1.17'

    input:
        tuple val(sample), file(sam)
    output:
        tuple val(sample), path("${sample}_filter.fq.gz"), emit: non_host_reads

    script:

    """
    samtools sort -m ${task.memory.toGiga()}G -@ ${task.cpus} ${sam} -o ${sample}_sorted.sam
    samtools view -f 4 ${sample}_sorted.sam > ${sample}_sorted_unmapped.sam
    samtools view -bS ${sample}_sorted_unmapped.sam > ${sample}_sorted_unmapped.bam
    samtools fastq -@ ${task.cpus} ${sample}_sorted_unmapped.sam -1 ${sample}_filter.fq.gz
    """
}


//    samtools view -bS ${sam} > ${sample}.bam
//    samtools view -b -f4 ${sample}.bam > ${sample}_unmapped.bam
//    samtools sort -n -m ${task.memory.toGiga()}G -@ ${task.cpus} ${sample}_unmapped.bam -o ${sample}_unmapped_sorted.bam
//    samtools fastq -@ ${task.cpus} ${sample}_unmapped_sorted.bam -1 ${sample}_filter.fq.gz