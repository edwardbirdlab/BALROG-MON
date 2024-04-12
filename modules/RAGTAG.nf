process RAGTAG {
    label 'midmemlong'
    container 'ebird013/ragtag:2.1.0'
    publishDir "${params.project_name}/Assembly/${task.process}", mode: 'copy', overwrite: true

    input:
        file(fasta)
        file(ref)
    output:
        tuple val(sample), path("whoknows"), emit: patched_genome

    script:

    """
    ragtag.py patch ${ref} ${fasta}
    """
}