process gtdbtk_db {
    label 'small'
    container 'library://edwardbird/bara/gtdbtk:1.5.0'
    publishDir "${params.project_name}/DB_Download/gtdbtk_DB", mode: 'copy', overwrite: false

    output:
        path("./out_db"), emit: DB

    script:

    """
    mkdir out_db
    wget https://data.gtdb.ecogenomic.org/releases/release207/207.0/auxillary_files/gtdbtk_r207_v2_data.tar.gz
    tar -xf gtdbtk_r207_v2_data.tar.gz -C out_db
    """
}