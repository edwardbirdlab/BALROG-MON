process RESFINDER {
   label 'lowmem'
    container 'ebird013/resfinder:4.4.2'
    publishDir "${params.project_name}/AMR_Annotation/resfinder", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
        path(db)

    output:
        path("./${sample}"), emit: resfinder_results

    script:

    """
    python3 -m resfinder -o ./${sample} -l 0.6 -t 0.8 -ifa ${fasta} -acq -c -db_res ./${db}
    """
}