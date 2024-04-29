process CARD_READS {
   label 'lowmem'
    container 'ebird013/rgi:6.0.3'
    publishDir "${params.project_name}/AMR_Annotation/CARD/${task.process}", mode: 'copy', overwrite: true

    input:
        tuple val(sample), file(R1)
        tuple val(db_name), path(db)
    output:
        path("./${sample}"), emit: results

    script:

    """
    mkdir ${sample}
    rgi clean --local
    rgi load --card_json ${db} --local
    rgi bwt --read_one ${R1} --output_file ./${sample}/${sample}_out --local --clean -a bwa
    """
}