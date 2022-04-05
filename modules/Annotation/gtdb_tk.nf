process gtdbtk {
    container 'ecogenomic/gtdbtk:1.5.0'
    containerOptions = "--user root"
    publishDir "${params.project_name}/prokka_genome", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
    output:
        path("./${sample}"), emit: prokka_results

    script:

    """
    mkdir fasta_dir
    cp ${fasta} fasta_dir
    gtdbtk classify_wf --out_dir ${sample} --prefix ${sample} --genome_dir fasta_dir --cpus 19 
    """
}