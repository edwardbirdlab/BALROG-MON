process card_plasmid {
   label 'lowmem'
    container 'library://edwardbird/bara/rgi:5.1.1'
    publishDir "${params.project_name}/AMR_Annotation/CARD_plasmid", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
        tuple val(db_name), path(db)
    output:
        path("./${sample}"), emit: card_plasmid_results

    script:

    """
    mkdir ${sample}
    rgi main --input_sequence $fasta --output_file ./${sample}/${sample}_out --input_type contig --local --clean
    """
}