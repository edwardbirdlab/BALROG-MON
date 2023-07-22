process PLASMER_DB {
    label 'small'
    output:
        tuple path("customizedKraken2DB.tar.xz"), path("plasmerMainDB.tar.xz"), emit: plasmer_DB

    script:

    """
    wget https://zenodo.org/record/7030675/files/customizedKraken2DB.tar.xz
    wget https://zenodo.org/record/7030675/files/plasmerMainDB.tar.xz
    """
}