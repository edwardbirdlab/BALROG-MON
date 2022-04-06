process gtdbtk_db {

    container 'ecogenomic/gtdbtk:1.5.0'
    publishDir "${params.project_name}/gtdbtk_DB", mode: 'copy', overwrite: false

    output:
        path("./out_db"), emit: DB

    script:

    """
    mkdir out_db
    wget https://data.gtdb.ecogenomic.org/releases/latest/auxillary_files/gtdbtk_data.tar.gz
    tar -xf gtdbtk_data.tar.gz -C out_db
    """
}