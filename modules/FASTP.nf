process FASTP {
    label 'verylow'
	container 'library://edwardbirdlab/fastp/fastp:1.0'
    publishDir "${params.project_name}/Pre_Processing/fastp/${sample}", mode: 'symlink', overwrite: false

    input:
        tuple val(sample), file(R1), file(R2)
    output:
	    tuple val(sample), path("${sample}_trim_R1.fq.gz"), path("${sample}_trim_R2.fq.gz"), emit: trimmed_fastq
	    tuple val(sample), path("${sample}.fastp.html"), emit: fastp_html
        tuple val(sample), path("${sample}.fastp.json"), emit: fastp_json


    script:

    def adapter_arg_1 = params.fastp_adap1 ? "--adapter_sequence ${params.fastp_adap1}" : ""
    def adapter_arg_2 = params.fastp_adap2 ? "--adapter_sequence_r2 ${params.fastp_adap2}" : ""

    """
    fastp -i ${R1} -I ${R2} -o ${sample}_trim_R1.fq.gz -O ${sample}_trim_R2.fq.gz -q ${params.fastp_q} --json ${sample}.fastp.json --html ${sample}.fastp.html  \\
    $adapter_arg_1 \\
    $adapter_arg_2
    """
}