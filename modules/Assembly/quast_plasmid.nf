process quast {
        label 'lowmem'
    container 'library://edwardbird/bara/quast:5.0.2'
    publishDir "${params.project_name}/Assembly/quast_plasmid", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
    output:
        path("./${sample}"), emit: quast_results

    script:

    """
    quast.py -o ${sample} ${fasta} --threads ${params.thread_max}
    """
}