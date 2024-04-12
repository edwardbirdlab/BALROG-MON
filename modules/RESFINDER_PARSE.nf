process RESFINDER_PARSE {
   label 'ultralow'
    container 'ebird013/balrog:2.4'
    publishDir "${params.project_name}/AMR_Annotation/ResfinderParse", mode: 'copy', overwrite: true

    input:
        file(outputs)

    output:
        tuple val('Resfinder'), path("resfinder_refernce_hits.fasta"), emit: fasta

    script:     

    """
    mkdir toprocess
    mv *.fsa ./toprocess
    parse_resfinder.py ./toprocess resfinder_refernce_hits.fasta
    """
}