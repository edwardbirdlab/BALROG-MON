process CONCAT_FA {
    label 'lowmem'
    //container 'ebird013/longstitch:1.0.5'
    publishDir "${params.project_name}/Assembly/${task.process}", mode: 'symlink', overwrite: true

    input:
        file(fastas)

    output:
        path("concat_fasta.fna"), emit: concat_fa

    script:

    """
    cat ${fastas} > concat_fasta.fna
    """
}