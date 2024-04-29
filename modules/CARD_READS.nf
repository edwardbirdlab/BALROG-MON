process CARD_READS {
   label 'lowmem'
    container 'library://edwardbird/bara/rgi:5.1.1'
    publishDir "${params.project_name}/AMR_Annotation/CARD/${task.process}", mode: 'copy', overwrite: true

    input:
        tuple val(sample), file(R1), file(R2)
        tuple val(db_name), path(db)
    output:
        path("./${sample}"), emit: results
        path("./${sample}/${sample}_out.txt"), emit: tbout

    script:

    """
    mkdir ${sample}
    rgi clean --local
    rgi load --card_json ${db} --local
    rgi bwt --read_one ${R1} --read_two ${R2} --output_file ./${sample}/${sample}_out --local --clean -a bwa
    """
}