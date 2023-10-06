process BLAST_MAKEDB {
    label 'lowmem'
    container 'library://edwardbird/bara/ncbi_blast:1.0'
    publishDir "${params.project_name}/ARG_Database_Merge/blast_db", mode: 'copy', overwrite: false

    input:
        file(fasta)

    output:
        path("./custom_blastdb"), emit: db

    script:

    """
    mkdir custom_blastdb
    makeblastdb -in ${fasta} -out custom_db -dbtype nucl
    mv custom_db.* custom_blastdb
    """
}