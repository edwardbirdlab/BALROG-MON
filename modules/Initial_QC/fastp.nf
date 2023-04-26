process fastp {
    label 'lowmem'
	container 'library://edwardbirdlab/fastp/fastp:1.0'
    publishDir "${params.project_name}/Pre_Processing/fastp", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fastqs)
    output:
	    tuple val(new_sample), path("${new_sample}.R1.fq.gz"), path("${new_sample}.R2.fq.gz"), emit: trimmed_fastq
	    tuple val(new_sample), path("fastp.html"), emit: fastp_html
        tuple val(new_sample), path("fastp.json"), emit: fastp_json


    script:

    new_sample = sample + '_trim'

    """
    fastp -i ${fastqs[0]} -I ${fastqs[1]} -o ${new_sample}.R1.fq.gz -O ${new_sample}.R2.fq.gz -q $params.fastp_q
    """
}