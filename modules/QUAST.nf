process QUAST {
    label 'lowmem'
    container 'ebird013/quast:5.2.0'
    publishDir "${params.project_name}/Quast/${task.process}", mode: 'copy', overwrite: false
    errorStrategy 'ignore'

    input:
        tuple val(sample), file(fasta)

    output:
        path("./${sample}"), emit: quast_results

    script:

    """
    quast.py -o ${sample} ${fasta} --threads ${task.cpus} --min-contig 0
    """
}