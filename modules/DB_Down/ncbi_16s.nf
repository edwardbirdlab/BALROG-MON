process db_16s {

    publishDir "${params.project_name}/db_16s", mode: 'copy', overwrite: false

    output:
        path("./amr_DB"), emit: db_16s

    script:

    """
    mkdir amr_DB
    cd amr_DB
    update_blastdb.pl 16S_ribosomal_RNA
    cd ..
    """
}