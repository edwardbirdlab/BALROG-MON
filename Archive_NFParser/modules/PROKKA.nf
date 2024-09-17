process PROKKA {
    label 'lowmem'
    container 'library://edwardbird/bara/prokka:1.14.5'

    input:
        tuple val(sample), file(fasta)
    output:
        path("./${sample}"), emit: prokka_results

    script:

    """
    prokka --outdir ${sample} --prefix ${sample} ${fasta} --cpus ${task.cpus} --centre X --compliant
    """
}