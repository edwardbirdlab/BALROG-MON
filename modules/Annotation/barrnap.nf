process barrnap {
    label 'lowmem'
    container 'library://edwardbird/bara/barrnap:0.9'
    publishDir "${params.project_name}/Identificaiton/barrnap", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
    output:
        tuple val(sample), path("${sample}_seqs.fa"), emit: barrnap_results

    script:

    """
    barrnap --quiet $fasta --outseq ${sample}_seqs.fa
    """
}