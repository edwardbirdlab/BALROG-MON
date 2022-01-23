process fastqc {
	container 'pegi3s/fastqc:latest'
    input:
        tuple val(sample), file(fastqs)
    output:
        file("${sample}_fastqc.tar")

    script:

    """
    mkdir ${sample}_fastqc
    fastqc -o ${sample}_fastqc -t 19 ${fastqs[0]} ${fastqs[1]}
    tar -cvf ${sample}_fastqc.tar ${sample}_fastqc
    """
}