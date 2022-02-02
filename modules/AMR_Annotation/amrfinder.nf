process amrfinder {
    container 'staphb/ncbi-amrfinderplus'
    containerOptions = "--user root"
    publishDir "${params.project_name}/AMRFinder", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
    output:
        path("./${sample}_AMRFinder.tsv"), emit: amrfinder_results

    script:

    """
    amrfinder -n ${fasta} -o ${sample}_AMRFinder.tsv
    """
}