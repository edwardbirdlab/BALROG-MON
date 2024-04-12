process VIRSORTER2_DB {
    label 'lowmem'
    container 'ebird013/virsorter2:2.2.4'
    publishDir "${params.project_name}/Assembly/viral_verify", mode: 'copy', overwrite: false

    output:
        path("db"), emit: database

    script:

    """
    wget https://osf.io/v46sc/download
    tar -xzf download
    """
}