process RESFINDER_DB {
    label 'small'
    container 'ebird013/resfinder:4.4.2'
    publishDir "${params.project_name}/ARG_Databases/resfinder_DB", mode: 'copy', overwrite: false

    output:
        path("./db_resfinder"), emit: resfinder_db
        path("resfinder_db.fasta"), emit: resfinder_fasta
        path("resfinder_db.fasta"), emit: only_fa

    script:

    """
    git clone https://git@bitbucket.org/genomicepidemiology/resfinder_db.git db_resfinder
    cd db_resfinder
    cp all.fsa ../resfinder_db.fasta
    cd ..
    """
}

//    python3 INSTALL.py kma_index non_interactive