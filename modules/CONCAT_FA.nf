process CONCAT_FA {
    label 'lowmem'
    container 'ebird013/seqtk:1.4'

    input:
        file(fastas)

    output:
        path("concat_fasta.fna"), emit: concat_fa

    script:

    """
    cat ${fastas} > concat_fasta.fna
    """
}