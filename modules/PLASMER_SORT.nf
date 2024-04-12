process PLASMER_SORT {
    label 'lowmem'
    container 'quay.io/biocontainers/python:3.9--1'
    publishDir "${params.project_name}/Assembly/plasmer/${sample}", mode: 'copy', overwrite: false


    input:
        tuple val(sample), path(pred), path(prob), path(contigs)

    output:
        tuple val(sample), path("*plasmid.fasta"), emit: plasmid, optional: true
        tuple val(sample), path("*chromosome.fasta"), emit: chromosome, optional: true
        tuple val(sample), path("*tooshort.fasta"), emit: tooshort, optional: true
        tuple val(sample), path("*allclass.fasta"), emit: all
        tuple val(sample), path("*plasmersort_stats.txt"), emit: stats


    script:

    """
    plasmer_sorting.py ${pred} ${prob} ${contigs}
    """
}