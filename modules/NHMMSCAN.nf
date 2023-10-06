process NHMMSCAN {
    label 'lowmem'
    container 'ebird013/hmmer:3.3.1'
    publishDir "${params.project_name}/ARG_Database_Merge/nhmmscan", mode: 'copy', overwrite: false

    input:
        path(merge_db)
        path(bacrascan_nhmm)


    output:
        path('merge_db_predictions.out'), emit: predict
        



    
        
    script:

    """
    tar -xf ${bacrascan_nhmm}
    nhmmscan --cpu ${task.cpus} -E ${params.bacscan_nhmm_eval} --tblout merge_db_predictions.out nARGhmm/254_nARG.hmm ${merge_db}
    """
}