process KRAKEN2_DB_PLUSPF {
    label 'small'
    output:
        tuple path("inspect.txt"), path('k2_pluspf_20231009.tar.gz'), emit: kraken2_DB
        path("library_report.tsv"), emit: lib_report

    script:

    """
    wget https://genome-idx.s3.amazonaws.com/kraken/pluspf_20231009/inspect.txt
    wget https://genome-idx.s3.amazonaws.com/kraken/k2_pluspf_20231009.tar.gz
    wget https://genome-idx.s3.amazonaws.com/kraken/pluspf_20231009/library_report.tsv
    """
}