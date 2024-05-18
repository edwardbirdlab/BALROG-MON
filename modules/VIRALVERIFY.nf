process VIRALVERIFY {
    label 'lowmem'
    container 'library://edwardbirdlab/bara/viralverify:latest'

    input:
        tuple val(sample), file(fasta)
        path(DB)
    output:
        path("${sample}/*"), emit: out_dir

    script:

    """
    viralverify -f ${fasta} -o ${sample} --hmm ${DB} -t ${task.cpus} -p
    """
}