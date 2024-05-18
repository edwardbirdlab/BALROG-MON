process AMRFINDER_DB {
   label 'lowmem'
    container 'ncbi/amr:latest'

    input:

    output:
        path("amrfinder_db_down/"), emit: amrfinder_db

    script:

    """
    amrfinder_update -d amrfinder_db_down
    """
}