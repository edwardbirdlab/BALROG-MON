process busco {
    container 'ezlabgva/busco:v5.2.2_cv2'
    publishDir "${params.project_name}/busco", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
    output:
        path("${sample}.tar.gz"), emit: quast_results

    script:

    """
    busco -i ${fasta} -o ${sample} -m genome
    tar -zcvf ${sample}.tar.gz ./${sample}
    """
}