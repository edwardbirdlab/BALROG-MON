process gtdbtk {
    container 'ecogenomic/gtdbtk:1.5.0'
    containerOptions = "--user root"
    publishDir "${params.project_name}/gtdbtk", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
        path(db)
    output:
        path("./${sample}"), emit: prokka_results

    script:

    """
    GTDBTK_DATA_PATH="./${db}/"
    mkdir fasta_dir
    cp ${fasta} fasta_dir
    gtdbtk classify_wf --out_dir ${sample} --prefix ${sample} --genome_dir fasta_dir --cpus 19 
    """
}