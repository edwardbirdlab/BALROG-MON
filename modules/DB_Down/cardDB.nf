process card_DB {
    label 'small'
    publishDir "${params.project_name}/card_DB", mode: 'copy', overwrite: false

    output:
        path("./localDB"), emit: card_DB

    script:

    """
    mkdir localDB
    cd localDB
    wget https://card.mcmaster.ca/latest/data
    tar -xvf data ./card.json
    """
}