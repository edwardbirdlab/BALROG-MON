process fastqc {
	publishDir "${out_dir}/${project_name}/test_data_set", mode: 'copy', overwrite: false
	container 'biocontainers/fastqc'
    input:
        set sample, file(fastq_1), file(fastq_2) from raw_read_3
    output:
        file("${sample}_fastqc.tar") into fastqc_raw_files

    script:

    """
    mkdir ${sample}_fastqc
    fastqc -o ${sample}_fastqc -t $thread_max ${fastq_1} ${fastq_2}
    tar -cvf ${sample}_fastqc.tar ${sample}_fastqc
    """
}