process resfinder_db {

    container 'resfinder:1.0'
    publishDir "${params.project_name}/resfinder_DB", mode: 'copy', overwrite: false

    output:
        path("./db_resfinder"), emit: resfinder_DB

    script:

    """
    git clone https://git@bitbucket.org/genomicepidemiology/resfinder_db.git db_resfinder
    cd db_resfinder
    python3 INSTALL.py kma_index non_interactive
    cd ..
    """
}