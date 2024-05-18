process PORECHOP {
    label 'porechop'
	container 'ebird013/porechop:0.2.4'

    input:
        tuple val(sample), file(R1)
    output:
        tuple val(sample), path("./${sample}_pc.fastq.gz"), emit: fastq
        path("porechop_${sample}.log"), emit: log

    script:

    """
    porechop -i ${R1} -o ${sample}_pc.fastq.gz --verbosity 1 &> porechop_${sample}.log
    """
}