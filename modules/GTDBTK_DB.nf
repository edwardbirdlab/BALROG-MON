process GTDBTK_DB {
    label 'small'

    output:
        path("*.tar.gz"), emit: DB

    script:

    """
    wget https://data.gtdb.ecogenomic.org/releases/release207/207.0/auxillary_files/gtdbtk_r207_v2_data.tar.gz
    """
}