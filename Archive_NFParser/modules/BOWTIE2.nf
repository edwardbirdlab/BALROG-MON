process BOWTIE2 {
    label 'lowmemlong'
    container 'biocontainers/bowtie2:v2.4.1_cv1'

    input:
        tuple val(sample), file(fq1), file(fq2), file(ref)
    output:
        tuple val(sample), path("${sample}_host_removal.sam"), emit: sam

    script:

    """
    bowtie2-build ${ref} host_DB
    bowtie2 -p ${task.cpus}  -x host_DB -1 ${fq1} -2 ${fq2} -S ${sample}_host_removal.sam
    """
}