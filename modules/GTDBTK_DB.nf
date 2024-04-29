process GTDBTK_DB {
    label 'small'
    //container 'library://edwardbird/bara/gtdbtk:1.5.0'
    publishDir "${params.project_name}/DB_Download/gtdbtk_DB", mode: 'copy', overwrite: false

    output:
        path("*.tar.gz"), emit: DB

    script:

    """
    wget https://data.gtdb.ecogenomic.org/releases/release207/207.0/auxillary_files/gtdbtk_r207_v2_data.tar.gz
    """
}