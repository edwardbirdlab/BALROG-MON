process FASTQC {
    label 'ultralow'
	container 'ebird013/fastqc:0.12.1'

    input:
        tuple val(sample), file(R1), file(R2)
        val(adapt)
        
    output:
        tuple val(sample), path("./${sample}_fastqc"), emit: fastq

    script:

    """
    mkdir ${sample}_fastqc
    fastqc -o ${sample}_fastqc -t ${task.cpus} -a ${adapt} ${R1} ${R2}
    """
}