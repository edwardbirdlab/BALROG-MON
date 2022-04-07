process prokka {
    label 'lowmem'
    container 'staphb/prokka:1.14.5'
    containerOptions = "--user root"
    publishDir "${params.project_name}/prokka_plasmid", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
    output:
        path("./${sample}"), emit: prokka_results

    script:

    """
    prokka --outdir ${sample} --prefix ${sample} ${fasta} --cpus 19 --centre X --compliant
    """
}