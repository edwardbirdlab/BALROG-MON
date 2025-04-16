process KRAKEN2_DB_CUSTOM {
    label 'kracken2'
    container 'ebird013/kraken2:latest'

    input:
        val(dbs)
    output:
        path "${db_dir}", emit: db

    script:
    def download_cmds = dbs.collect { db -> "kraken2-build --download-library ${db} --db custom_kraken2_db" }.join('\n')

    """
    mkdir -p custom_kraken2_db

    kraken2-build --download-taxonomy --db custom_kraken2_db

    ${download_cmds}

    kraken2-build --build --db custom_kraken2_db --threads ${task.cpus}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        Kraken2: \$(kraken2 -v 2>&1 | grep "Kraken version" | sed -e "s/Kraken version //g")
        Kraken2_DBs: ${dbs}
    END_VERSIONS 
    """
}