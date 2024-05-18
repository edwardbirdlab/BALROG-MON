process AMRFINDER {
   label 'lowmemnk'
    container 'ncbi/amr:latest'

    input:
        tuple val(sample), file(fasta)
        val(db)
    output:
        path("./${sample}_AMRFinder.tsv"), emit: amrfinder_results

    script:

    """
    mkdir tmpamr
    TMPDIR="./tmpamr"
    amrfinder -d ${db}/latest -n ${fasta} -o ${sample}_AMRFinder.tsv
    """
}