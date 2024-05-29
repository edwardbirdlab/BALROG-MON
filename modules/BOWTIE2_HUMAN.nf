process BOWTIE2_HUMAN {
    label 'lowmemlong'
    container 'biocontainers/bowtie2:v2.4.1_cv1'

    input:
        tuple val(sample), file(fq1), file(fq2), file(index)
    output:
        tuple val(sample), path("${sample}_human_removal.sam"), emit: sam
        tuple val(sample), path("${sample}_human_removed_R1.fastq.gz"), path("${sample}_human_removed_R2.fastq.gz"), emit: dep_reads


    script:

    """
    unzip ${index}
    bowtie2 -p ${task.cpus}  -x GRCh38_noalt_as -1 ${fq1} -2 ${fq2} --very-sensitive-local --un-conc-gz ${sample}_human_removed > ${sample}_human_removal.sam
    mv ${sample}_human_removed.1 ${sample}_human_removed_R1.fastq.gz
    mv ${sample}_human_removed.2 ${sample}_human_removed_R2.fastq.gz
    """
}