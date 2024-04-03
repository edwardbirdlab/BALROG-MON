process KRAKENUNIQ_DB {
    container 'ebird013/kracken_uniq:1.0.3'
    label 'small'
    output:
        tuple path("database.kdb"), path('kuniq_microbialdb.kdb.20200816.tgz'), emit: krackenuniq_DB

    script:

    """
    wget https://genome-idx.s3.amazonaws.com/kraken/uniq/MicrobialDB_202008/database.kdb
    wget https://genome-idx.s3.amazonaws.com/kraken/uniq/MicrobialDB_202008/kuniq_microbialdb.kdb.20200816.tgz
    """
}