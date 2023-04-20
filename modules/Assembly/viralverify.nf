process viralverify {
    label 'lowmem'
    container 'library://edwardbirdlab/bara/viralverify:latest'
    publishDir "${params.project_name}/Assembly/viral_verify", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
        path(DB)
    output:
        path("${sample}/*"), emit: out_dir

    script:

    """
    viralverify -f ${fasta} -o ${sample} --hmm ${DB} -t ${params.thread_max} -p
    """
}