process SYLPH_SKETCH_GTDB {
    label 'lowmem'
    container 'ebird013/seqtk:1.4'
    publishDir "${params.project_name}/Identificaion/${task.process}", mode: 'symlink', overwrite: true

    input:
        file(gtdb)
        file(ref)
    output:
        path("gtdb_database"), emit: gtdb_sylph

    script:

    """
    mkdir db
    tar -xf gtdbtk_r207_v2_data.tar.gz -C db --strip-components=1
    find db | grep .fna > gtdb_all.txt
    cat gtdb_all.txt ${ref} > gtdb_ref.txt
    sylph sketch -l gtdb_ref.txt -t 50 -o gtdb_ref_database
    """
}