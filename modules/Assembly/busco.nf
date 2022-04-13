process busco {
    label 'lowmem'
    container '/scratch/vlpicken/Github/containers/busco_v5.2.2_cv2.sif'
    publishDir "${params.project_name}/busco", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
    output:
        path("./${sample}"), emit: quast_results

    script:

    """
    busco -i ${fasta} -o ${sample} -m genome
    """
}