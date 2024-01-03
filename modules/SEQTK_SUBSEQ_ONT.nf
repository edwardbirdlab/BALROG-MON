process SEQTK_SUBSEQ_ONT {
    label 'lowmem'
    container 'ebird013/seqtk:1.4'
    publishDir "${params.project_name}/Host_Depletion/${task.process}", mode: 'copy', overwrite: true

    input:
        tuple val(sample), file(fastq), file(fq_list)
    output:
        tuple val(sample), path("${sample}_readsubset.fastq"), emit: read_subset

    script:

    """
    seqtk subseq ${fastq} ${fq_list} > ${sample}_readsubset.fastq
    """
}