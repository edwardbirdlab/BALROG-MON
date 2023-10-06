process resfinder_genome {
   label 'lowmem'
    container 'library://edwardbird/bara/resfinder:4.0'
    publishDir "${params.project_name}/AMR_Annotation/resfinder_genome", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
        path(db)

    output:
        path("./${sample}"), emit: resfinder_genome_results

    script:

    """
    cd ${db}
    python3 INSTALL.py non_interactive
    cd ..
    python3 /usr/src/run_resfinder.py -o ./${sample} -l 0.6 -t 0.8 -ifa ${fasta} -acq -db_res ./${db}
    """
}