process gtdbtk {
    label 'bigmem'
    container 'library://edwardbird/bara/gtdbtk:1.5.0'
    publishDir "${params.project_name}/gtdbtk", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
        path(db)
    output:
        path("./${sample}"), emit: prokka_results

    script:

    """
    GTDBTK_DATA_PATH="./${db}/release202"
    mkdir fasta_dir
    cp ${fasta} fasta_dir
    gtdbtk classify_wf --out_dir ${sample} --prefix ${sample} --genome_dir fasta_dir --cpus 1 --extension fasta
    """
}