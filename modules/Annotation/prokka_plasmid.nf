process prokka_plasmid {
    label 'lowmem'
    container 'library://edwardbird/bara/prokka:1.14.5'
    publishDir "${params.project_name}/Annotation/prokka_plasmid", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
    output:
        path("./${sample}"), emit: prokka_results

    script:

    """
    prokka --outdir ${sample} --prefix ${sample} ${fasta} --cpus 19 --centre X --compliant
    """
}