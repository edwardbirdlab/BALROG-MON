process gtdbtk_db {

    container 'ecogenomic/gtdbtk:1.5.0'
    publishDir "${params.project_name}/gtdbtk_DB", mode: 'copy', overwrite: false

    output:
        path("./gtdbtk_data"), emit: DB

    script:

    """
    wget https://data.gtdb.ecogenomic.org/releases/latest/auxillary_files/gtdbtk_data.tar.gz
    tar xvzf gtdbtk_data.tar.gz
    """
}