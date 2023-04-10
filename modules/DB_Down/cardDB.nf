process card_DB {
    label 'small'
    publishDir "${params.project_name}/card_DB", mode: 'copy', overwrite: false

    output:
        path("./localDB"), emit: card_DB
        path("nucleotide_fasta_protein_homolog_model.fasta"), emit: card_nucleotide_PHM_fasta
        path("protein_fasta_protein_homolog_model.fasta"), emit: card_protein_PHM_fasta


    script:

    """
    mkdir localDB
    wget https://card.mcmaster.ca/latest/data
    tar -xvf data
    cp card.json ./localDB
    """
}