process BOWTIE2_UNALIGN {
    label 'lowmem'
    container 'biocontainers/bowtie2:v2.4.1_cv1'
    publishDir "${params.project_name}/Host_Depletion/Bowtie2", mode: 'symlink', overwrite: true

    input:
        tuple val(sample), file(fq1), file(fq2), file(ref)
    output:
        tuple val(sample), path("${sample}_NonHost_R1.fq.gz"), path("${sample}_NonHost_R2.fq.gz"), emit: non_host_reads

    script:

    """
    bowtie2-build ${ref} host_DB
    bowtie2 -p 8 -x host_DB -1 ${fq1} -2 ${fq2} --un-conc-gz ${sample}_NonHost_R%.fq.gz -S ${sample}_host.sam
    """
}