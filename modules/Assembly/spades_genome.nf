process spades_genome {
    container 'quay.io/biocontainers/spades:3.14.0--h2d02072_0'
    publishDir "${params.project_name}/spades_genome", mode: 'copy', overwrite: false

    input:
        tuple val(sample), path(fastq1), path(fastq2)
    output:
        tuple val(sample), path("${sample}_scaffolds.fasta"), emit: genome
        tuple val(sample), path("./${sample}"), emit spades_genome_dir

    script:

    """
    spades.py -k 21,33,55,77 --careful --only-assembler --pe1-1 ${fastq1} --pe1-2 ${fastq2} -o ${sample} -t 19
    cp ${sample}/scaffolds.fasta ${sample}_scaffolds.fasta 
    """
}