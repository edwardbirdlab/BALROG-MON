process FASTQC {
    label 'ultralow'
	container 'ebird013/fastqc:0.12.1'
    publishDir "${params.project_name}/Pre_Processing/FastQC/${task.process}", mode: 'copy', overwrite: true

    input:
        tuple val(sample), file(R1), file(R2)
    output:
        tuple val(sample), path("./${sample}_fastqc"), emit: fastq

    script:

    """
    mkdir ${sample}_fastqc
    fastqc -o ${sample}_fastqc -t ${task.cpus} ${R1} ${R2}
    """
}