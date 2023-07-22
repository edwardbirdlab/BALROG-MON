process argdit_checkdb_nt {
    label 'lowmem'
    container 'library://edwardbirdlab/bara/argdit:odseq.1.0'
    publishDir "${params.project_name}/ARG_Database_Merge/argdit_checkdb_nt", mode: 'copy', overwrite: false

    input:
        tuple val(config_val), path(argdit_config)
        file(db_nt_fasta)


    output:
        path('*.log'), emit: db_check_log


    
        
    script:

    """
    cp -R /opt/ARGDIT .
    cd ARGDIT
    rm -rf config.ini
    cp ../config.ini .
    cd ..
    ./ARGDIT/check_arg_db.py -e ${db_nt_fasta}
    """
}