process spades_plasmid {
    label 'medmem'
    container 'library://edwardbird/bara/spades:3.14.0'
    publishDir "${params.project_name}/Assembly/spades_plasmid", mode: 'copy', overwrite: false

    input:
        tuple val(sample), path(fastq1), path(fastq2)
    output:
        tuple val(sample), path("${sample}_scaffolds.fasta"), emit: plasmids
        tuple val(sample), path("./${sample}"), emit: spades_plasmid_dir

    script:

    """
    spades.py -k 21,33,55,77 --careful --only-assembler -m 16 --plasmid --pe1-1 ${fastq1} --pe1-2 ${fastq2} -o ${sample} -t 19
    cp ${sample}/scaffolds.fasta ${sample}_scaffolds.fasta 
    """
}