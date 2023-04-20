process plasmidverify {
    label 'lowmem'
    container 'library://edwardbird/bara/plasmid_verify:1.0.1'
    publishDir "${params.project_name}/Assembly/plasmid_verify", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
        path(DB)
    output:
        path("${sample}/*"), emit: out_dir

    script:

    """
    plasmidverify.py -f ${fasta} -o ${sample} --hmm ${DB} -t ${params.thread_max}
    """
}