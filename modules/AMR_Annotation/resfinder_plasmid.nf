process resfinder_plasmid {
   label 'lowmem'
    container 'ebird013/resfinder:4.0'
    publishDir "${params.project_name}/resfinder_plasmid", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
        path(db)

    output:
        path("./${sample}"), emit: resfinder_plasmid_results

    script:

    """
    cd ${db}
    python3 INSTALL.py non_interactive
    cd ..
    python3 /usr/src/run_resfinder.py -o ./${sample} -l 0.6 -t 0.8 -ifa ${fasta} -acq -db_res ./${db}
    """
}