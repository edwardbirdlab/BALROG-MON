process QUAST {
    label 'lowmem'
    container 'library://edwardbird/bara/quast:5.0.2'
    publishDir "${params.project_name}/Quast/${meta}", mode: 'copy', overwrite: false
    errorStrategy 'ignore'

    input:
        tuple val(sample), file(fasta)
        val(meta)

    output:
        path("./${sample}"), emit: quast_results

    script:

    """
    quast.py -o ${sample} ${fasta} --threads ${task.cpus} --min-contig 0
    """
}