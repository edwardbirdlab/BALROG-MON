process FASTP {
    label 'verylow'
	container 'biocontainers/fastp:v0.20.1_cv1'

    input:
        tuple val(sample), file(R1), file(R2)
    output:
	    tuple val(sample), path("${sample}_R1.fq.gz"), path("${sample}_R2.fq.gz"), emit: trimmed_fastq
	    tuple val(sample), path("${sample}.fastp.html"), emit: fastp_html
        tuple val(sample), path("${sample}.fastp.json"), emit: fastp_json


    script:

    def adapter_arg_1 = params.fastp_adap1 ? "--adapter_sequence ${params.fastp_adap1}" : ""
    def adapter_arg_2 = params.fastp_adap2 ? "--adapter_sequence_r2 ${params.fastp_adap2}" : ""

    """
    fastp -i ${R1} -I ${R2} -o ${sample}_R1.fq.gz -O ${sample}_R2.fq.gz -q ${params.fastp_q} -l ${params.fastp_minlen} --json ${sample}.fastp.json --html ${sample}.fastp.html  \\
    $adapter_arg_1 \\
    $adapter_arg_2
    """
}