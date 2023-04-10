process amrfinder_db {
   label 'lowmem'
    container 'library://edwardbird/bara/ncbi-amrfinderplus:1.0'
    publishDir "${params.project_name}/AMRFinder_db", mode: 'copy', overwrite: false

    input:

    output:
        path("./data"), emit: amrfinder_db

    script:

    """
    amrfinder_update --database=data
    """
}