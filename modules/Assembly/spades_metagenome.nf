process spades_metagenome {
    label 'lowmem'
    container 'library://edwardbird/bara/spades:3.14.0'
    publishDir "${params.project_name}/Assembly/spades_metagenome", mode: 'copy', overwrite: false

    input:
        tuple val(sample), path(fastq1), path(fastq2)
    output:
        tuple val(sample), path("${sample}_scaffolds.fasta"), emit: spades_metagenome
        tuple val(sample), path("./${sample}"), emit: spades_metagenome_dir

    script:

    """
    spades.py --meta -m 16 --pe1-1 ${fastq1} --pe1-2 ${fastq2} -o ${sample} -t 16
    cp ${sample}/scaffolds.fasta ${sample}_scaffolds.fasta 
    """
}