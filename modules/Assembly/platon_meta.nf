process platon_meta {
    label 'lowmem'
    container 'library://edwardbirdlab/bara/platon:latest'
    publishDir "${params.project_name}/Assembly/platon_meta", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
        path(DB)
    output:
        tuple val(sample), path("platon_${sample}/*.tsv"), emit: report
        tuple val(sample), path("platon_${sample}/*.log"), emit: log
        tuple val(sm_gen), path("platon_${sample}/*.chromosome.fasta"), emit: predict_chr
        tuple val(sm_plas), path("platon_${sample}/*.plasmid.fasta"), emit: predict_plas
        
    script:

    sm_plas = sample + '_plasmid'
    sm_gen = sample + '_genome'


    """
    tar -xzf $DB
    platon --db db --meta --output platon_${sample} --mode sensitivity --threads 16 ${fasta}
    """
}