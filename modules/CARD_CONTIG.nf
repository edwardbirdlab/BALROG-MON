process CARD_CONTIG {
   label 'lowmemlong'
    container 'ebird013/rgi:6.0.3'

    input:
        tuple val(sample), file(fasta)
        tuple val(db_name), path(db)
    output:
        path("./${sample}"), emit: results
        path("./${sample}/${sample}_out.txt"), emit: tbout
        tuple val(sample), path("./${sample}/${sample}_out.txt"), path("versions.yml"), emit: for_hamr
        path("versions.yml"), emit: versions

    script:

    """
    mkdir ${sample}
    rgi clean --local
    rgi load --card_json ${db} --local
    rgi main --input_sequence $fasta --output_file ./${sample}/${sample}_out --input_type contig --local --clean

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        rgi: \$(rgi main -v 2>&1)
        card: \$(rgi database -v 2>&1)
    END_VERSIONS
    """
}