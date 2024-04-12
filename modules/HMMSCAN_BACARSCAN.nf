process HMMSCAN_BACARSCAN {
    label 'lowmem'
    container 'ebird013/hmmer:3.3.1'
    publishDir "${params.project_name}/MULTI_AMR/nhmmscan", mode: 'copy', overwrite: true

    input:
        tuple val(db_name), path(pt_db)
        path(bacarscan_hmm)


    output:
        path("${db_name}_bacarscan.out"), emit: predict
        


    script:

    """
    tar -xf ${bacarscan_hmm}
    hmmscan --cpu ${task.cpus} -E ${params.bacscan_nhmm_eval} --tblout ${db_name}_bacarscan.out pARGhmm/254_pARG.hmm ${pt_db}
    """
}