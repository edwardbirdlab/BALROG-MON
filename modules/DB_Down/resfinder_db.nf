process resfinder_db {
    label 'small'
    container 'library://edwardbird/bara/resfinder:4.0'
    publishDir "${params.project_name}/resfinder_DB", mode: 'copy', overwrite: false

    output:
        tuple val('resfinder'), path("./db_resfinder"), emit: resfinder_DB
        tuple val('resfinder'), path("all.fasta"), emit: resfinder_fasta
        path("all.fasta"), emit: only_fa

    script:

    """
    git clone https://git@bitbucket.org/genomicepidemiology/resfinder_db.git db_resfinder
    cd db_resfinder
    python3 INSTALL.py kma_index non_interactive
    cp all.fsa ../all.fasta
    cd ..
    """
}