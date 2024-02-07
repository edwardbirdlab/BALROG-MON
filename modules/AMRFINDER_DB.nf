process AMRFINDER_DB {
   label 'lowmem'
    container 'ncbi/amr:latest'
    publishDir "${params.project_name}/ARG_Databases/AMRFinder_db", mode: 'copy', overwrite: false

    input:

    output:
        path("amrfinder_db_down/"), emit: amrfinder_db

    script:

    """
    amrfinder_update -d amrfinder_db_down
    """
}