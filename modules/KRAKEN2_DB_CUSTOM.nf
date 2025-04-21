process KRAKEN2_DB_CUSTOM {
    label 'k2_custom_db'
    container 'ebird013/kraken2:latest'

    input:
        val(dbs)
    output:
        path("custom_kraken2_db"), emit: db
        path("versions.yml"), emit: versions

    script:
    def download_cmds = dbs.split(/\s+/).collect { db -> "kraken2-build --download-library ${db} --db custom_kraken2_db" }.join('\n')

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