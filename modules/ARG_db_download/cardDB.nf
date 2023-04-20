process card_DB {
    label 'small'
    publishDir "${params.project_name}/ARG_Databases/card_DB", mode: 'copy', overwrite: false

    output:
        tuple val('card'), path("./localDB"), emit: card_DB
        tuple val('card'), path("card_phm_nt_db.fasta"), emit: card_nucleotide_PHM_fasta
        path("card_phm_nt_db.fasta"), emit: only_fa
        tuple val('card'), path("protein_fasta_protein_homolog_model.fasta"), emit: card_protein_PHM_fasta


    script:

    """
    mkdir localDB
    wget https://card.mcmaster.ca/latest/data
    tar -xvf data
    cp card.json ./localDB
    cp nucleotide_fasta_protein_homolog_model.fasta card_phm_nt_db.fasta
    """
}