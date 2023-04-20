process gtdbtk {
    label 'bigmem'
    container 'library://edwardbirdlab/bara/gtdbtk_2:latest'
    publishDir "${params.project_name}/Identificaiton/gtdbtk", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
        path(db)
    output:
        path("./${sample}"), emit: prokka_results


    script:
    """
    GTDBTK_DATA_PATH="./${db}/release207_v2"
    mkdir fasta_dir
    cp ${fasta} fasta_dir
    gtdbtk classify_wf --out_dir ${sample} --prefix ${sample} --genome_dir fasta_dir --cpus 1 --extension fasta
    """
}