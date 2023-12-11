process KRAKEN2_DB_PLUSPF {
    label 'small'
    output:
        tuple path("inspect.txt"), path('k2_pluspf_20230605.tar.gz'), emit: kraken2_DB

    script:

    """
    wget https://genome-idx.s3.amazonaws.com/kraken/pluspf_20230605/inspect.txt
    wget https://genome-idx.s3.amazonaws.com/kraken/k2_pluspf_20230605.tar.gz
    """
}