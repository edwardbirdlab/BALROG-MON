process quast {
        label 'lowmem'
    container 'quay.io/biocontainers/quast:5.0.2--py37pl526hb5aa323_2'
    publishDir "${params.project_name}/quast_plasmid", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
    output:
        path("./${sample}"), emit: quast_results

    script:

    """
    quast.py -o ${sample} ${fasta} --threads ${params.thread_max}
    """
}