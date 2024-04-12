process AMRFINDER {
   label 'lowmemnk'
    container 'ncbi/amr:latest'
    publishDir "${params.project_name}/AMR_Annotation/AMRFinder", mode: 'copy', overwrite: true

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