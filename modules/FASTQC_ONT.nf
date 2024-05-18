process FASTQC_ONT {
    label 'lowmem'
	container 'ebird013/fastqc:0.12.1'

    input:
        tuple val(sample), file(R1)
    output:
        tuple val(sample), path("./${sample}_fastqc"), emit: fastq

    script:

    """
    mkdir ${sample}_fastqc
    fastqc -o ${sample}_fastqc -t ${task.cpus} ${R1}
    """
}