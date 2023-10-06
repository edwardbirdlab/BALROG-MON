process SPADES_METAGENOME {
    label 'lowmem'
    container 'library://edwardbird/bara/spades:3.14.0'
    publishDir "${params.project_name}/Assembly/spades_metagenome", mode: 'copy', overwrite: false

    input:
        tuple val(sample), path(fastq1), path(fastq2)
    output:
        tuple val(sample), path("${sample}_scaffolds.fasta"), emit: metagenome
        tuple val(sample), path("./${sample}"), emit: metagenome_dir

    script:

    """
    spades.py --meta -m ${task.memory.toGiga()} --pe1-1 ${fastq1} --pe1-2 ${fastq2} -o ${sample} -t ${task.cpus}
    cp ${sample}/scaffolds.fasta ${sample}_scaffolds.fasta 
    """
}