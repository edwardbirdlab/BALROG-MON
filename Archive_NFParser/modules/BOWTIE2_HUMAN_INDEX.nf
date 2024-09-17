process BOWTIE2_HUMAN_INDEX {
    label 'lowmem'
    container 'biocontainers/bowtie2:v2.4.1_cv1'

    output:
        path("GRCh38_noalt_as.zip"), emit: index

    script:

    """
    wget https://genome-idx.s3.amazonaws.com/bt/GRCh38_noalt_as.zip
    """
}