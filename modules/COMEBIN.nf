process COMEBIN {
    label 'midmemlong'
    container 'ebird013/combine:1.0.3'

    input:
        tuple val(sample), file(scaffolds), file(bam)
    output:
        tuple val(sample), path("./${sample}_comebin_out"), emit: bins

    script:

    """
    mkdir ${sample}_bams
    mv ${bam} ${sample}_bams
    mkdir ${sample}_comebin_out
    run_comebin.sh -a ${scaffolds} -p ${sample}_bams -o ${sample}_comebin_out -n ${params.comebin_num_views} -t ${task.cpus}
    """
}