process SAMTOOLS_EXTRACT_UNMAPPED_ONT {
    label 'samtoolssort'
    container 'ebird013/samtools:1.17'

    input:
        tuple val(sample), file(sam)
    output:
        tuple val(sample), path("${sample}_filter.fq.gz"), emit: non_host_reads
        path("versions.yml"), emit: versions

    script:

    """
    samtools view -bS ${sam} > ${sample}.bam
    samtools sort -n -m ${task.memory.toGiga()}G -@ ${task.cpus} ${sample}.bam -o ${sample}_sorted.bam
    samtools view -b -f 4 ${sample}_sorted.bam > ${sample}_sorted_unmapped.bam
    samtools fastq -@ ${task.cpus} ${sample}_sorted_unmapped.bam> ${sample}_filter.fq
    gzip ${sample}_filter.fq

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        Samtools: \$(samtools --version 2>&1 | grep "samtools " | sed -e "s/samtools //g")
    END_VERSIONS 
    """
}


