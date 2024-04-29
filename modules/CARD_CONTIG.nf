process CARD_CONTIG {
   label 'lowmemlong'
    container 'ebird013/rgi:6.0.3'
    publishDir "${params.project_name}/AMR_Annotation/CARD/${task.process}", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
        tuple val(db_name), path(db)
    output:
        path("./${sample}"), emit: results
        path("./${sample}/${sample}_out.txt"), emit: tbout

    script:

    """
    mkdir ${sample}
    rgi clean --local
    rgi load --card_json ${db} --local
    rgi main --input_sequence $fasta --output_file ./${sample}/${sample}_out --input_type contig --local --clean
    """
}