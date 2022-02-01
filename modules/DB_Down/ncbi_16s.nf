process db_16s {

    publishDir "${params.project_name}/db_16s", mode: 'copy', overwrite: false

    output:
        path("./16s_db"), emit: db_16s

    script:

    """
    mkdir 16s_db
    cd 16s_db
    update_blastdb.pl 16S_ribosomal_RNA
    tar -xf 16S_ribosomal_RNA.tar.gz
    cd ..
    """
}