process CARD_READS {
   label 'lowmem'
    container 'ebird013/rgi:6.0.3'

    input:
        tuple val(sample), file(R1), file(R2)
        tuple val(db_name), path(db)
    output:
        path("./${sample}"), emit: results

    script:

    """
    mkdir ${sample}
    rgi clean --local
    rgi load --card_json ${db} --local

    rgi card_annotation -i ${db} > card_annotation.log 2>&1
    rgi load -i ${db} --card_annotation card_database_v3.2.9.fasta --local

    rgi bwt --read_one ${R1} --read_two ${R2} --output_file ./${sample}/${sample}_out --local --clean -a bowtie2 -n ${task.cpus}
    """
}