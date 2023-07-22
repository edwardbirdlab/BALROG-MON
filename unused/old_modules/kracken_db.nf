process kracken_db {
    label 'small'
    output:
        tuple val('kracken_db'), path("database.kdb"), path('kuniq_standard_minus_kdb.20220616.tgz'), emit: kracken_DB

    script:

    """
    wget https://genome-idx.s3.amazonaws.com/kraken/uniq/krakendb-2022-06-16-STANDARD/database.kdb
    wget https://genome-idx.s3.amazonaws.com/kraken/uniq/krakendb-2022-06-16-STANDARD/kuniq_standard_minus_kdb.20220616.tgz
    """
}