process platon_db {
    label 'small'
    output:
        path("db.tar.gz"), emit: platon_DB

    script:

    """
    wget https://zenodo.org/record/4066768/files/db.tar.gz
    """
}