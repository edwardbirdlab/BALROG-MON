process RESFINDER_PARSE {
   label 'ultralow'
    container 'ebird013/balrog:2.4'

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