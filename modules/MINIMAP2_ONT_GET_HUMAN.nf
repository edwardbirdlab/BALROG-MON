process MINIMAP2_ONT_GET_HUMAN {
    label 'midmemlong'
    container 'ebird013/minimap2:2.26'

    output:
        path("GCA_000001405.15_GRCh38_genomic.fna"), emit: ref
        path("versions.yml"), emit: versions

    script:

    """
    wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/GCA_000001405.15_GRCh38_genomic.fna.gz
    gunzip GCA_000001405.15_GRCh38_genomic.fna.gz

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        Minimap2: \$(minimap2 --version 2>&1)
        Human_Genome: GCA_000001405.15
    END_VERSIONS 
    """
}