process QUAST {
    label 'lowmem'
    container 'ebird013/quast:5.2.0'

    input:
        tuple val(sample), file(fasta)

    output:
        path("./${sample}"), emit: quast_results

    script:

    """
    mv ${fasta} ${sample}.fasta
    quast.py -o ${sample} ${sample}.fasta --threads ${task.cpus} --min-contig 0
    """
}