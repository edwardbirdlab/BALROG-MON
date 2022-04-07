process plasmidverify_db {
    label 'small'
    output:
        path("Pfam-A.hmm"), emit: pfam_DB

    script:

    """
    wget ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.hmm.gz
    gunzip Pfam-A.hmm.gz
    """
}