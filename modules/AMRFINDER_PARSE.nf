process AMRFINDER_PARSE {
   label 'ultralow'
    container 'ebird013/balrog:2.1'

    input:
        file(outputs)
        val(db)
    output:
        tuple val('amrfinder'), path("amrfinder_refernce_hits.fasta"), emit: fasta

    script:

    """
    mkdir toprocess
    mv *.tsv toprocess
    parse_amrfinder.py ${db}/latest ./toprocess amrfinder_refernce_hits.fasta
    """
}