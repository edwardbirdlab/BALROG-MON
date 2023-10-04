process FASTP {
    label 'lowmem'
	container 'library://edwardbirdlab/fastp/fastp:1.0'
    publishDir "${params.project_name}/Pre_Processing/fastp", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(R1), file(R2)
    output:
	    tuple val(sample), path("${sample}.R1.fq.gz"), path("${sample}.R2.fq.gz"), emit: trimmed_fastq
	    tuple val(sample), path("fastp.html"), emit: fastp_html
        tuple val(sample), path("fastp.json"), emit: fastp_json


    script:

    """
    fastp -i ${R1} -I ${R2} -o ${sample}.R1.fq.gz -O ${sample}.R2.fq.gz -q $params.fastp_q
    """
}