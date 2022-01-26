process quast {
    container 'quay.io/biocontainers/quast:5.0.2--py37pl526hb5aa323_2'
    publishDir "${params.project_name}/quast", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
    output:
        path("${sample}.tar.gz"), emit: quast_results

    script:

    """
    quast.py -o ${sample} ${fasta} --threads ${params.thread_max}
    tar -zcvf ${sample}.tar.gz ./${sample}
    """
}