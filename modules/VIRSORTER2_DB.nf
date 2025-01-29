process VIRSORTER2_DB {
    label 'lowmem'
    container 'ebird013/virsorter2:2.2.4'

    output:
        path("db"), emit: database
        path("versions.yml"), emit: versions

    script:

    """
    wget https://osf.io/v46sc/download
    tar -xzf download

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        Virsorter2: \$(virsorter --version 2>&1 | grep "VirSorter" | sed -E "s/.*VirSorter //g")
    END_VERSIONS 
    """
}