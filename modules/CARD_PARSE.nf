process CARD_PARSE {
   label 'ultralow'
    container 'ebird013/balrog:2.2'

    input:
        file(outputs)

    output:
        tuple val('CARD'), path("card_refernce_hits.fasta"), emit: fasta

    script:

    """
    mkdir toprocess
    mv *.txt ./toprocess
    parse_card.py ./toprocess card_refernce_hits.fasta
    """
}