process megares {
    label 'small'
    container 'library://edwardbird/bara/gtdbtk:1.5.0'
    publishDir "${params.project_name}/ARG_Databases/megares", mode: 'copy', overwrite: false

    output:
        tuple val('megares'), path("./megares_v3.00.zip"), emit: megares_DB
        tuple val('megares'), path("megares_database_v3_db.fasta"), emit: megares_fasta
        tuple val('megares'), path("megares_annotations_v3.00.csv"), emit: megares_annot
        path("megares_database_v3_db.fasta"), emit: only_fa
        path("megares_database_v3_schema.sc"), emit: only_sc



    script:

    """
    wget https://www.meglab.org/downloads/megares_v3.00/megares_database_v3.00.fasta
    wget https://www.meglab.org/downloads/megares_v3.00/megares_annotations_v3.00.csv
    wget https://www.meglab.org/downloads/megares_v3.00.zip
    cp megares_database_v3.00.fasta megares_database_v3_db.fasta
    cp megares_database_v3.00.fasta megares_database_v3_schema.sc
    """
}