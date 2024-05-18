process CARD_DB {
    label 'small'

    output:
        tuple val('card'), path("card.json"), emit: card_DB


    script:

    """
    mkdir localDB
    wget https://card.mcmaster.ca/latest/data
    tar -xvf data
    cp card.json ./localDB
    cp nucleotide_fasta_protein_homolog_model.fasta card_phm_nt_db.fasta
    """
}