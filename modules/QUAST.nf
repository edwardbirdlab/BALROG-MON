process QUAST {
    label 'lowmem'
    container 'ebird013/quast:5.2.0'

    input:
        tuple val(sample), file(fasta)

    output:
        path("./${sample}"), emit: quast_results
        path("versions.yml"), emit: versions

    script:

    """
    mv ${fasta} ${sample}.fasta
    quast.py -o ${sample} ${sample}.fasta --threads ${task.cpus} --min-contig 0

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        Quast: \$(samtools --version 2>&1 | grep "QUAST" | sed -e "s/QUAST //g")
    END_VERSIONS 
    """
}