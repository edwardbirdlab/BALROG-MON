process SYLPH_SKETCH_GTDB {
    label 'lowmem'
    container 'ebird013/sylph:0.5.1_exec'
    publishDir "${params.project_name}/Identificaion/${task.process}", mode: 'symlink', overwrite: true

    input:
        file(gtdb)
        file(ref)
    output:
        path("gtdb_ref_database.syldb"), emit: gtdb_sylph

    script:

    """
    mkdir db
    tar -xf gtdbtk_r207_v2_data.tar.gz -C db --strip-components=1
    find db | grep .fna > gtdb_all.txt
    sylph sketch ${ref} -l gtdb_all.txt -t ${task.cpus} -o gtdb_ref_database
    """
}