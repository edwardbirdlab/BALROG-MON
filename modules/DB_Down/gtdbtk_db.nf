process gtdbtk_db {
    label 'small'
    container 'ebird013/gtdbtk:1.5.0'
    publishDir "${params.project_name}/gtdbtk_DB", mode: 'copy', overwrite: false

    output:
        path("./out_db"), emit: DB

    script:

    """
    mkdir out_db
    wget https://data.gtdb.ecogenomic.org/releases/release202/202.0/auxillary_files/gtdbtk_r202_data.tar.gz
    tar -xf gtdbtk_r202_data.tar.gz -C out_db
    """
}