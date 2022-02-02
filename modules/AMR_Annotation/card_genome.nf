process card_genome {
    container 'quay.io/biocontainers/rgi:5.1.1--py_0'
    publishDir "${params.project_name}/CARD_genome", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
        path(db)
    output:
        path("./${sample}"), emit: card_genome_results

    script:

    """
    mkdir ${sample}
    rgi main --input_sequence $fasta --output_file ./${sample}/${sample}_out --input_type contig --local --clean
    """
}