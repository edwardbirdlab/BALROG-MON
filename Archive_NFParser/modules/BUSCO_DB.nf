process BUSCO_DB {
    label 'lowmem'
    container 'ebird013/busco:5.7.1'
        
    output:
        path("./busco_downloads"), emit: busco_db

    script:

    """
    busco --download ${params.busco_lineage}
    """
}