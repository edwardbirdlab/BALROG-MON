process fastqc {
    label 'lowmem'
	container 'library://edwardbird/bara/fastqc:0.11.9'
    publishDir "${params.project_name}/Pre_Processing/raw_fastqc", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(R1), file(R2)
    output:
        tuple val(sample), path("./${sample}_fastqc"), emit: fastq

    script:

    """
    mkdir ${sample}_fastqc
    fastqc -o ${sample}_fastqc -t 19 ${R1} ${R2}
    """
}