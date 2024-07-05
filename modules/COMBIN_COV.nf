process COMBIN_COV {
    label 'midmemlong'
    container 'ebird013/combine:1.0.3'

    input:
        tuple val(sample), file(contigs), file(reads)
    output:
        tuple val(sample), path("./${sample}_bams"), emit: bam_dir

    script:

    """
    mkdir ${sample}_bams
    gen_cov_file.sh -a ${contigs} -o ${sample}_bams --single-end ${reads} -t ${task.cpus} -m ${task.memory.toGiga()} -l ${params.combin_min_contig}
    """
}