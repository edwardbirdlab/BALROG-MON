process VIRSORTER2_DB {
    label 'lowmem'
    container 'ebird013/virsorter2:2.2.4'

    output:
        path("db"), emit: database

    script:

    """
    wget https://osf.io/v46sc/download
    tar -xzf download
    """
}