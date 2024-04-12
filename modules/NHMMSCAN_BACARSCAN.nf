process NHMMSCAN_BACARSCAN {
    label 'lowmem'
    container 'ebird013/hmmer:3.3.1'
    publishDir "${params.project_name}/MULTI_AMR/nhmmscan", mode: 'copy', overwrite: true

    input:
        tuple val(db_name), path(nt_db)
        path(bacarscan_nhmm)


    output:
        path("${db_name}_bacarscan.out"), emit: predict
        


    script:

    """
    tar -xf ${bacarscan_nhmm}
    nhmmscan --cpu ${task.cpus} -E ${params.bacscan_nhmm_eval} --tblout ${db_name}_bacarscan.out nARGhmm/254_nARG.hmm ${nt_db}
    """
}