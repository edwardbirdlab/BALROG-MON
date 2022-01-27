process plasmidverify {
    container 'metashot/spades:3.15.1-1'
    publishDir "${params.project_name}/Viral_verify", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
        path(DB)
    output:
        path("${sample}/*"), emit: out_dir
        path("${sample}/Prediction_results_fasta/*.fa"), emit: vv_plasmids

    script:

    """
    plasmidverify.py -f ${fasta} -o ${sample} --hmm ${DB} -p -t ${params.thread_max}
    """
}