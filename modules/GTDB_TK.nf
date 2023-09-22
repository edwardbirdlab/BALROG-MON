process GTDB_TK {
    label 'plasmer'
    container 'library://edwardbirdlab/bara/gtdbtk_2:latest'
    publishDir "${params.project_name}/Identificaiton/gtdbtk", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
        path(db)
    output:
        path("./${sample}"), emit: results


    script:
    """
    mkdir db
    tar -xf gtdbtk_r207_v2_data.tar.gz -C db --strip-components=1
    GTDBTK_DATA_PATH="db"
    mkdir fasta_dir
    cp ${fasta} fasta_dir
    gtdbtk classify_wf --out_dir ${sample} --prefix ${sample} --genome_dir fasta_dir --cpus ${task.cpus} --extension fasta
    """
}