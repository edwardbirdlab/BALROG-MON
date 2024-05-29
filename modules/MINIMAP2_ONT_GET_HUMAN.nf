process MINIMAP2_ONT {
    label 'midmemlong'
    container 'ebird013/minimap2:2.26'

    output:
        path("GCA_000001405.15_GRCh38_genomic.fna"), emit: ref

    script:

    """
    wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/GCA_000001405.15_GRCh38_genomic.fna.gz
    gunzip https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/GCA_000001405.15_GRCh38_genomic.fna.gz
    """
}