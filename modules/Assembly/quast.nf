process quast {
    container 'quay.io/biocontainers/quast:5.0.2--py37pl526hb5aa323_2'
    publishDir "${params.project_name}/quast", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
    output:
        path(${sample}), emit: quast_results
        path(report_${sample}.tsv) emit: quast_tsv

    script:

    """
    quast.py --out-dir ${sample} ${fasta} --threads ${params.thread_max}
    mv ${sample}/report.tsv ./report_${sample}.tsv
    """
}