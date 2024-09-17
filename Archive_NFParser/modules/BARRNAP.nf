process BARRNAP {
    label 'lowmem'
    container 'library://edwardbird/bara/barrnap:0.9'

    input:
        tuple val(sample), file(fasta)
    output:
        tuple val(sample), path("${sample}_seqs.fa"), emit: barrnap_results

    script:

    """
    barrnap --quiet $fasta --outseq ${sample}_seqs.fa
    """
}