process fastqc {
	container 'pegi3s/fastqc:latest'
    publishDir "${params.project_name}/raw_fastqc", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fastqs)
    output:
        path("${sample}_fastqc.tar.gz"), emit: rawfastq

    script:

    """
    mkdir ${sample}_fastqc
    fastqc -o ${sample}_fastqc -t 19 ${fastqs[0]} ${fastqs[1]}
    tar -zcvf ${sample}_fastqc.tar.gz ${sample}_fastqc
    """
}