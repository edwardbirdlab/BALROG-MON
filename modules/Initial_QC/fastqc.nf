process fastqc {
	publishDir "${out_dir}/${project_name}/test_data_set", mode: 'copy', overwrite: false
	container 'pegi3s/fastqc:latest'
    input:
        tuple val(sample), file(fastq_1), file(fastq_2)
    output:
        file("${sample}_fastqc.tar")

    script:

    """
    mkdir ${sample}_fastqc
    fastqc -o ${sample}_fastqc -t 19 ${fastq_1} ${fastq_2}
    tar -cvf ${sample}_fastqc.tar ${sample}_fastqc
    """
}