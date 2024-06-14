process FASTQC {
    label 'ultralow'
	container 'ebird013/fastqc:0.12.1_custom'

    input:
        tuple val(sample), file(R1), file(R2)
    output:
        tuple val(sample), path("./${sample}_fastqc"), emit: fastq

    script:

    def adapter_arg = params.fastqc_adapt ? "-a /opt/fastqc/fastqc_configs/${params.fastqc_adapt}" : ""

    """
    mkdir ${sample}_fastqc
    fastqc -o ${sample}_fastqc -t ${task.cpus} ${R1} ${R2} \\
    $adapter_arg
    """
}