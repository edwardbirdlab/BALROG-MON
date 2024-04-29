process SPADES_GENOME {
    label 'lowmem'
    container 'ebird013/spades:3.15.5'
    publishDir "${params.project_name}/Assembly/spades_genome", mode: 'copy', overwrite: false

    input:
        tuple val(sample), path(fastq1), path(fastq2)
    output:
        tuple val(sample), path("${sample}_scaffolds.fasta"), emit: genome
        tuple val(sample), path("./${sample}"), emit: spades_genome_dir

    script:

    """
    spades.py --isolate -m ${task.memory.toGiga()} --pe1-1 ${fastq1} --pe1-2 ${fastq2} -o ${sample} -t ${task.cpus}
    cp ${sample}/scaffolds.fasta ${sample}_scaffolds.fasta 
    """
}