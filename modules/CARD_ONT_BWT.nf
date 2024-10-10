process CARD_ONT_BWT {
   label 'lowmem'
    container 'ebird013/rgi:6.0.3_custom'

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

    rgi card_annotation -i ${db} > card_annotation.log 2>&1
    rm *all.fasta
    mv card_database_*.fasta card_database.fasta
    rgi load -i ${db} --card_annotation card_database.fasta --local

    rgi bwt --read_one ${R1} --output_file ./${sample}/${sample}_out --local --clean -a kma -n ${task.cpus} --kma_ont

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        rgi_bwt: \$(rgi bwt -v 2>&1)
        card: \$(rgi database -v 2>&1)
    END_VERSIONS
    """
}