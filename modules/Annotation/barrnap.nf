process barrnap {
    container 'barrnap:1.0'
    containerOptions = "--user root"
    publishDir "${params.project_name}/barrnap", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
    output:
        tuple val(sample), path("${sample}_seqs.fa"), emit: barrnap_results

    script:

    """
    barrnap --quiet $fasta --outseq ${sample}_seqs.fa
    """
}